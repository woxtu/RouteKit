//
//  RouterTests.swift
//  RouteKitTests
//
//  Created by woxtu on 2018/03/14.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import XCTest
@testable import RouteKit

class RouterTests: XCTestCase {
    func testRouting() {
        struct TestResponse {
            let p: String
            let q: String?
        }
        
        struct TestRoute: Route {
            let path = "/{p}"
            
            struct Parameters: Decodable {
                let p: String
            }
            
            struct Queries: Decodable {
                let q: String?
            }
            
            func map(to url: URL, parameters: Parameters, queries: Queries) -> TestResponse {
                return TestResponse(p: parameters.p, q: queries.q)
            }
        }
        
        let router = Router<TestResponse>()
        router.append(route: TestRoute())
        
        XCTAssertNil(router.push(url: URL(string: "/")!))
        XCTAssertEqual(router.push(url: URL(string: "/p")!)?.p, "p")
        XCTAssertEqual(router.push(url: URL(string: "/p?q=q")!)?.q, "q")
    }
}
