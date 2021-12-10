//
//  Navigator.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/15.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import Foundation
import UIKit

open class Navigator {
	var router = Router<UIViewController>()

	let rootViewController: UIViewController

	public init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	public func append<R>(route: R) where R: Route, R.Response == UIViewController {
		router.append(route: route)
	}

	@discardableResult
	public func push(url: URL, animated: Bool) -> UIViewController? {
		if
			let viewController = self.router.push(url: url),
			let navigationController = self.rootViewController as? UINavigationController {
			navigationController.pushViewController(viewController, animated: animated)
			return viewController
		} else {
			return nil
		}
	}

	@discardableResult
	public func present(url: URL, animated: Bool, transform: ((UIViewController) -> UIViewController) = { $0 }) -> UIViewController? {
		return present(url: url, animated: animated, transform: transform, completion: nil)
	}

	@discardableResult
	public func present(url: URL, animated: Bool, transform: ((UIViewController) -> UIViewController) = { $0 }, completion: (() -> Void)? = nil) -> UIViewController? {
		if let viewController = self.router.push(url: url) {
			rootViewController.present(transform(viewController), animated: animated, completion: completion)
			return viewController
		} else {
			return nil
		}
	}
}
