//
//  NSRegularExpression+Extension.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/07.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    // swiftlint:disable:next line_length
    func stringByReplacingMatches(in string: String, options: NSRegularExpression.MatchingOptions = [], withTemplate templ: String) -> String {
        // swiftlint:disable:next line_length
        return stringByReplacingMatches(in: string, options: options, range: NSRange(location: 0, length: string.count), withTemplate: templ)
    }
}
