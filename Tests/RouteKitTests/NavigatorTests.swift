//
//  NavigatorTests.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/21.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit
import XCTest
@testable import RouteKit

class NavigatorTests: XCTestCase {
    func test() {
        let transform = { (vc: UIViewController) -> UIViewController in vc }
        let completion = { () -> Void in }
        
        Navigator.present(url: URL(string: "/")!, animated: true)
        Navigator.present(url: URL(string: "/")!, animated: true, transform: transform)
        Navigator.present(url: URL(string: "/")!, animated: true, completion: completion)
        Navigator.present(url: URL(string: "/")!, animated: true, transform: transform, completion: completion)
    }
}
#endif
