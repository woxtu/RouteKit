# RouteKit

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/v/RouteKit.svg?style=flat-square)](https://cocoapods.org/pods/RouteKit)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg?style=flat-square)](https://github.com/apple/swift-package-manager)

Type-safe URL routing for Swift.

```swift
// Define routes
struct UserIndex: Route {
    let path = "/users"

    func map(to url: URL, parameters: [String: String], queries: [String: String]) -> UIViewController {
        return UserIndexViewController()
    }
}

struct UserDetail: Route {
    let path = "/users/{id}"

    struct Parameters: Decodable {
        let id: Int
    }

    func map(to url: URL, parameters: Parameters, queries: [String: String]) -> UIViewController {
        return UserDetailViewController(id: parameters.id)
    }
}

// Use `Navigator` (for iOS)
Navigator.append(route: UserIndex())
Navigator.append(route: UserDetail())

Navigator.push(url: URL(string: "/users/42")!, animated: true)
Navigator.present(url: URL(string: "/users/42")!, animated: true)

// Use `Router`
let router = Router<UIViewController>()
router.append(route: UserIndex())
router.append(route: UserDetail())

router.push(url: URL(string: "/users/42")!) // Return `UserDetailViewController`
```

Greatly inspired by [ishkawa/APIKit](https://github.com/ishkawa/APIKit), [devxoul/URLNavigator](https://github.com/devxoul/URLNavigator).

## Installation

### Carthage

```
github "woxtu/RouteKit" ~> 0.2
```

### CocoaPods

```
pod 'RouteKit', '~> 0.2'
```

### Swift Package Manager

```
.package(url: "https://github.com/woxtu/RouteKit.git", from: "0.2.0")
```

## License

Licensed under the MIT license.
