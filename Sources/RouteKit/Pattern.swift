//
//  Pattern.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/07.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import Foundation

struct Pattern {
    enum Component {
        case constant(String)
        case variable(String)

        init(_ string: String) {
            if string.hasPrefix("{"), string.hasSuffix("}") {
                self = .variable(String(string.dropFirst().dropLast()))
            } else {
                self = .constant(string)
            }
        }
    }

    let scheme: String?
    let pathComponents: [Component]

    init(string: String) {
        // swiftlint:disable:next force_try identifier_name
        let re = try! NSRegularExpression(pattern: "/\\{.+?\\}(?=[/?]|$)")
        let urlComponents = URLComponents(string: re.stringByReplacingMatches(in: string, withTemplate: "/-"))

        scheme = urlComponents?.scheme

        pathComponents = string
            .replacingOccurrences(of: urlComponents?.scheme.map { "\($0):" } ?? "", with: "")
            .replacingOccurrences(of: urlComponents?.query.map { "?\($0)" } ?? "", with: "")
            .split(separator: "/")
            .map(String.init)
            .map(Component.init)
    }

    func match(url: URL) -> [String: String]? {
        let pathComponents = [url.host].compactMap { $0 } + url.pathComponents.dropFirst() // drop "/"

        if scheme == url.scheme, self.pathComponents == pathComponents.map(Component.init) {
            return zip(self.pathComponents, pathComponents).reduce(into: [:]) { result, component in
                if case let .variable(name) = component.0 {
                    result?[name] = component.1
                }
            }
        } else {
            return nil
        }
    }
}

extension Pattern.Component: Equatable {
    static func == (lhs: Pattern.Component, rhs: Pattern.Component) -> Bool {
        switch (lhs, rhs) {
        case let (.constant(lhs), .constant(rhs)): return lhs == rhs
        case let (.variable(lhs), .variable(rhs)): return lhs == rhs
        default: return true
        }
    }
}
