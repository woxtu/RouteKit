//
//  NavigatorTests.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/21.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

#if os(iOS) || os(tvOS)
    @testable import RouteKit
    import UIKit
    import XCTest

    class NavigatorTests: XCTestCase {
		let navigtor = Navigator()

        func test() {
            let transform = { (vc: UIViewController) -> UIViewController in vc }
            let completion = { () -> Void in }

			navigtor.present(url: URL(string: "/")!, animated: true)
			navigtor.present(url: URL(string: "/")!, animated: true, transform: transform)
			navigtor.present(url: URL(string: "/")!, animated: true, completion: completion)
			navigtor.present(url: URL(string: "/")!, animated: true, transform: transform, completion: completion)
        }
    }
#endif
