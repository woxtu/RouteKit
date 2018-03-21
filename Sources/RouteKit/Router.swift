//
//  Router.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/14.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import Foundation

open class Router<T> {
    private var routes = [AnyRoute<T>]()
    
    public init() {
        
    }
    
    open func append<R>(route: R) where R : Route, R.Response == T {
        self.routes.append(AnyRoute(route))
    }
    
    @discardableResult
    open func push(url: URL) -> T? {
        let queries = url.queryItems?.reduce(into: [:]) { result, item in
            result[item.name] = item.value ?? "true"
        } ?? [:]
                
        for route in self.routes {
            if
                let parameters = route.pattern.match(url: url),
                let response = route.map(url, parameters, queries)
            {
                return response
            }
        }
        
        return nil
    }
}
