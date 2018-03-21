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

    @discardableResult
    open static func present(url: URL, animated: Bool, transform: ((UIViewController) -> UIViewController) = { $0 }) -> UIViewController? {
        return self.present(url: url, animated: animated, transform: transform, completion: nil)
    }
    
    @discardableResult
    open static func present(url: URL, animated: Bool, transform: ((UIViewController) -> UIViewController) = { $0 }, completion: (() -> Void)? = nil) -> UIViewController? {
        if let viewController = self.router.push(url: url) {
            self.rootViewController?.present(viewController, animated: animated, completion: completion)
            return viewController
        } else {
            return nil
        }
    }
}
#endif
