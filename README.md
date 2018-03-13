# RouteKit

Type-safe URL routing for Swift.

```swift
struct UserIndex : Route {
    let path = "/users"

    func map(to url: URL, parameters: [String : String], queries: [String : String]) {
        print("user index")
    }
}

struct UserDetail : Route {
    let path = "/users/{id}"

    struct Parameters : Decodable {
        let id: Int
    }

    func map(to url: URL, parameters: Parameters, queries: [String : String]) {
        print("user detail: \(parameters.id)")
    }
}

let router = Router<Void>()
router.append(route: UserIndex())
router.append(route: UserDetail())

router.push(url: URL(string: "/users/42")!) // user detail: 42
```

## License

Licensed under the MIT license.
