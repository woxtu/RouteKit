//
//  Route.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/02.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import Foundation

public protocol Route {
    associatedtype Response
    associatedtype Parameters : Decodable = [String : String]
    associatedtype Queries : Decodable = [String : String]
    
    var path: String { get }
    
    func map(to url: URL, parameters: Parameters, queries: Queries) -> Response
}
