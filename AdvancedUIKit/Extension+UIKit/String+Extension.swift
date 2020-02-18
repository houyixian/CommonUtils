//
//  String+Extension.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2020/2/18.
//  Copyright © 2020 侯逸仙. All rights reserved.
//

import Foundation

extension String {
    /// 去掉所有空格
    public var removeAllSpace: String {
        return replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }

    public var isEmail: Bool {
        let pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let matches = regularExpression.matches(in: self, options: .reportProgress, range: NSRange(location: 0, length: count))
            return matches.count > 0
        } catch {
            return false
        }
    }

    public var isChinesePhoneNumber: Bool {
        let pattern = "^1[0-9]{10}$"
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let matches = regularExpression.matches(in: self, options: .reportProgress, range: NSRange(location: 0, length: count))
            return matches.count > 0
        } catch {
            return false
        }
    }
}
