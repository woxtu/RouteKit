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
    let map: (URL, String, String) -> T?
    
    init<R>(_ route: R) where R : Route, R.Response == T {
        self.pattern = Pattern(string: route.path)

        self.map = { url, parameters, queries in
            do {
                let parameters = try JSONDecoder().decode(R.Parameters.self, from: parameters.data(using: .utf8)!)
                let queries = try JSONDecoder().decode(R.Queries.self, from: queries.data(using: .utf8)!)
                return route.map(to: url, parameters: parameters, queries: queries)
            } catch {
                print(error)
                return nil
            }
        }
    }
}
