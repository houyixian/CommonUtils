//
//  String+Extension.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2020/2/18.
//  Copyright © 2020 侯逸仙. All rights reserved.
//

import Foundation
import CommonCrypto

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
// - MARK: 加密扩展
extension String {
    public var md5To32: String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        data.withUnsafeBytes { (buffer) in
            _ = CC_MD5(buffer.baseAddress, CC_LONG(buffer.count), &hash)
        }
        return hash.map { String(format: "%02X", $0) }.joined()
    }

    /// 还不知道如何输出16位的md5
//    public var md5To16: String {
//        let data = Data(utf8)
//        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
//        data.withUnsafeBytes { (buffer) in
//            _ = CC_MD5(buffer.baseAddress, CC_LONG(buffer.count), &hash)
//        }
//        return hash.map { String(format: "%02X", $0) }.joined()
//    }

    public var base64Encode: String? {
        return data(using: .utf8)?.base64EncodedString(options: .init(rawValue: 0))
    }

    public var base64Decode: String? {
        guard let data = Data(base64Encoded: self, options: .init(rawValue: 0)) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}
