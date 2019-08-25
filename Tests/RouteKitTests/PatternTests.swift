//
//  PatternTests.swift
//  RouteKitTests
//
//  Created by woxtu on 2018/03/07.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

@testable import RouteKit
import XCTest

class PatternTests: XCTestCase {
    func testPattern1() {
        let pattern = Pattern(string: "scheme://x1/{x2}")
        XCTAssertEqual(pattern.scheme, "scheme")
        XCTAssertEqual(pattern.pathComponents, [.constant("x1"), .variable("x2")])
    }

    func testPattern2() {
        let pattern = Pattern(string: "/x1/{x2}")
        XCTAssertEqual(pattern.scheme, nil)
        XCTAssertEqual(pattern.pathComponents, [.constant("x1"), .variable("x2")])
    }

    func testPatternMatch() {
        XCTAssertNil(Pattern(string: "/x1/{x2}").match(url: URL(string: "/")!))
        XCTAssertEqual(Pattern(string: "/x1/{x2}").match(url: URL(string: "/x1/x2")!)!, ["x2": "x2"])
    }
}
