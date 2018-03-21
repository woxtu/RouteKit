//
//  Navigator.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/15.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
import UIKit

open class Navigator {
    private static var router = Router<UIViewController>()
    
    private static var rootViewController: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }

    open static func append<R>(route: R) where R : Route, R.Response == UIViewController {
        self.router.append(route: route)
    }
    
    @discardableResult
    open static func push(url: URL, animated: Bool) -> UIViewController? {
        if
            let viewController = self.router.push(url: url),
            let navigationController = self.rootViewController as? UINavigationController
        {
            navigationController.pushViewController(viewController, animated: animated)
            return viewController
        } else {
            return nil
        }
    }
    
    open static func pop(animated: Bool) {
        if let navigationController = self.rootViewController as? UINavigationController {
            navigationController.popViewController(animated: animated)
        }
    }
    
    @discardableResult
    open static func present(url: URL, animated: Bool, completion: (() -> Void)? = nil) -> UIViewController? {
        if let viewController = self.router.push(url: url) {
            self.rootViewController?.present(viewController, animated: animated, completion: completion)
            return viewController
        } else {
            return nil
        }
    }
}
#endif
