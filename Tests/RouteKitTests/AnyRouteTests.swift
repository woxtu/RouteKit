//
//  AnyRouteTests.swift
//  RouteKitTests
//
//  Created by woxtu on 2018/03/02.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import Foundation
import XCTest
@testable import RouteKit

class AnyRouteTests: XCTestCase {
    func testDefaultParametersRoute() {
        struct TestResponse {
            let x1: String
            let x2: String
        }
        
        struct TestRoute: Route {
            let path = "/"
            
            func map(to url: URL, parameters: [String : String], queries: [String : String]) -> TestResponse? {
                return TestResponse(x1: parameters["x", default: ""], x2: queries["x", default: ""])
            }
        }
        
        let route = AnyRoute<TestResponse>(TestRoute())
        let response = route.map(URL(string: "/")!, "{\"x\":\"foo\"}", "{\"x\":\"bar\"}")
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.x1, "foo")
        XCTAssertEqual(response?.x2, "bar")
    }

    func testCustomParametersRoute() {
        struct TestResponse {
            let x1: String
            let x2: String
        }
        
        struct TestRoute: Route {
            let path = "/"
            
            struct Parameters: Decodable {
                let x: String
            }
            
            struct Queries: Decodable {
                let x: String
            }
            
            func map(to url: URL, parameters: Parameters, queries: Queries) -> TestResponse? {
                return TestResponse(x1: parameters.x, x2: queries.x)
            }
        }
        
        let route = AnyRoute<TestResponse>(TestRoute())
        let response = route.map(URL(string: "/")!, "{\"x\":\"foo\"}", "{\"x\":\"bar\"}")
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.x1, "foo")
        XCTAssertEqual(response?.x2, "bar")
    }
}
