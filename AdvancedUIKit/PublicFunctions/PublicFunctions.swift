//
//  PublicFunctions.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2020/2/19.
//  Copyright © 2020 侯逸仙. All rights reserved.
//

import UIKit

public enum ScreenSnapshotError: Error {
    case notFoundWindow
    case failedGetCurrentContext
    case failedGetImageFromCurrentImageContext
}

public func screenSnapshot() throws -> UIImage {
    guard let window = UIApplication.shared.windows.first else {
        throw ScreenSnapshotError.notFoundWindow
    }
    guard let currentContext = UIGraphicsGetCurrentContext() else {
        throw ScreenSnapshotError.failedGetCurrentContext
    }
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
    defer {
        UIGraphicsEndImageContext()
    }
    window.layer.render(in: currentContext)
    if let image = UIGraphicsGetImageFromCurrentImageContext() {
        return image
    } else {
        throw ScreenSnapshotError.failedGetImageFromCurrentImageContext
    }
}
