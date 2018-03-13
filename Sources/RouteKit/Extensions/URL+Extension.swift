//
//  URL+Extension.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/14.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import Foundation

extension URL {
    var queryItems: [URLQueryItem]? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems
    }
}
