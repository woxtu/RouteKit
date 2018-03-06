//
//  NSRegularExpression+Extension.swift
//  RouteKit
//
//  Created by woxtu on 2018/03/07.
//  Copyright (c) 2018 woxtu. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    func stringByReplacingMatches(in string: String, options: NSRegularExpression.MatchingOptions = [], withTemplate templ: String) -> String {
        return self.stringByReplacingMatches(in: string, options: options, range: NSMakeRange(0, string.count), withTemplate: templ)
    }
}
