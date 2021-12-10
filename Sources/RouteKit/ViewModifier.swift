//
//  ViewModifier.swift
//  RouteKit
//
//  Created by Larry Tran on 12/10/21.
//  Copyright © 2021 woxtu. All rights reserved.
//

import Foundation
import SwiftUI

struct RouterViewModifier: ViewModifier {

	@Environment(\.navigator) var navigator

	let url: URL
	let presentation: Presentation
	let animated: Bool

	func body(content: Content) -> some View {
		content
			.onTapGesture {
				switch presentation {
				case .present:
					navigator.present(url: url, animated: animated)
				case .push:
					navigator.push(url: url, animated: animated)
				}
			}
	}
}

extension View {
	func routeOnTap(url: URL, presentation: Presentation, animated: Bool) -> some View {
		self.modifier(RouterViewModifier(url: url, presentation: presentation, animated: animated))
	}
}

enum Presentation {
	case present
	case push
}

private struct NavigatorKey: EnvironmentKey {
	static let defaultValue = Navigator()
}

extension EnvironmentValues {
  var navigator: Navigator {
	get { self[NavigatorKey.self] }
	set { self[NavigatorKey.self] = newValue }
  }
}
