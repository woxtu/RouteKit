//
//  PayloadDecoderTests.swift
//  RouteKitTests
//
//  Created by woxtu on 2018/03/08.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

@testable import RouteKit
import XCTest

// swiftlint:disable identifier_name nesting
class PayloadDecoderTests: XCTestCase {
    func testDecodeString() {
        struct TestStruct: Decodable {
            let x: String
        }

        let payload = ["x": "x"]
        XCTAssertNoThrow(try PayloadDecoder().decode(TestStruct.self, from: payload))
        XCTAssertEqual(try PayloadDecoder().decode(TestStruct.self, from: payload).x, "x")
    }

    func testDecodeInt() {
        struct TestStruct: Decodable {
            let x: Int
        }

        let payload = ["x": "42"]
        XCTAssertNoThrow(try PayloadDecoder().decode(TestStruct.self, from: payload))
        XCTAssertEqual(try PayloadDecoder().decode(TestStruct.self, from: payload).x, 42)
    }

    func testDecodeOptional() {
        struct TestStruct: Decodable {
            let x: String?
        }

        let payload = [String: String]()
        XCTAssertNoThrow(try PayloadDecoder().decode(TestStruct.self, from: payload))
        XCTAssertEqual(try PayloadDecoder().decode(TestStruct.self, from: payload).x, nil)
    }

    func testDecodeEnum() {
        enum TestEnum: String, Decodable {
            case type
        }

        struct TestStruct: Decodable {
            let x: TestEnum
        }

        let payload = ["x": "type"]
        XCTAssertNoThrow(try PayloadDecoder().decode(TestStruct.self, from: payload))
        XCTAssertEqual(try PayloadDecoder().decode(TestStruct.self, from: payload).x, .type)
    }
}

// swiftlint:enable identifier_name nesting
