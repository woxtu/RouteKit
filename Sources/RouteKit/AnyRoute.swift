//
//  AnyRoute.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/02.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import Foundation

struct AnyRoute<T> {
    let pattern: Pattern
    let map: (URL, [String: String], [String: String]) -> T?

    init<R>(_ route: R) where R: Route, R.Response == T {
        pattern = Pattern(string: route.path)

        map = { url, parameters, queries in
            do {
                let parameters = try PayloadDecoder().decode(R.Parameters.self, from: parameters)
                let queries = try PayloadDecoder().decode(R.Queries.self, from: queries)
                return route.map(to: url, parameters: parameters, queries: queries)
            } catch {
                print(error)
                return nil
            }
        }
    }
}
