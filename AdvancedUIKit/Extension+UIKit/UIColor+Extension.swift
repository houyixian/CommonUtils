//
//  UIColor+Extension.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2020/2/19.
//  Copyright © 2020 侯逸仙. All rights reserved.
//

import UIKit

extension UIColor {
    /// 根据6位的16进制颜色字符串和透明度来初始化UIColor
    /// - Parameter hexColor: 6位的16进制颜色字符串
    /// - Parameter alpha: 颜色透明度
    public convenience init(hexColor: String, alpha: CGFloat = 1) {
        if hexColor.isEmpty {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
            return
        }
        var refinedHexColorString = hexColor.trimmingCharacters(in: .whitespacesAndNewlines)
        if refinedHexColorString.count == 0 {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
            return
        }
        if refinedHexColorString.hasPrefix("#") {
            refinedHexColorString.remove(at: refinedHexColorString.startIndex)
        }
        if refinedHexColorString.count != 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
            return
        }
        let value = "0x\(refinedHexColorString)"
        let scanner = Scanner(string: value)
        var hexValue: UInt64 = 0
        // 查找16进制是否存在
        // Note: 假如6位的16进制颜色字符串出现了错误，比如"GGGGGG"，目前代码无法检测出类似的错误
        if scanner.scanHexInt64(&hexValue) {
            let redValue = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            let greenValue = CGFloat((hexValue & 0xFF00) >> 8) / 255.0
            let blueValue = CGFloat(hexValue & 0xFF) / 255.0
            self.init(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
        }
    }
}
