//
//  HollowView.swift
//  CommonUIKit
//
//  Created by 侯逸仙 on 2019/11/6.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit

public class AUHollowView: UIView {
    private let topDistance: CGFloat
    private let bottomDistance: CGFloat
    private let leftDistance: CGFloat
    private let rightDistance: CGFloat
    private let hollowCornerRadius: CGFloat
    private let maskShapeLayer = CAShapeLayer()

    /// 默认镂空的最小高度为0
    public var minHeight: CGFloat = 0

    private override init(frame: CGRect) {
        topDistance = 0
        bottomDistance = 0
        leftDistance = 0
        rightDistance = 0
        hollowCornerRadius = 0
        super.init(frame: frame)
    }

    public init(edge: UIEdgeInsets, hollowCornerRadius: CGFloat) {
        topDistance = edge.top
        bottomDistance = edge.bottom
        leftDistance = edge.left
        rightDistance = edge.right
        self.hollowCornerRadius = hollowCornerRadius
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        // 首先创建一个和当前视图一样大小的path
        let fullPath = UIBezierPath(rect: bounds)
        // 然后创建镂空的path
        let hollowPath = UIBezierPath(roundedRect: CGRect(x: leftDistance, y: topDistance, width: max(0, bounds.width - leftDistance - rightDistance), height: max(minHeight, bounds.height - topDistance - bottomDistance)), cornerRadius: hollowCornerRadius)
        fullPath.append(hollowPath)
        fullPath.usesEvenOddFillRule = true
        maskShapeLayer.path = fullPath.cgPath
        maskShapeLayer.fillRule = .evenOdd
        layer.mask = maskShapeLayer
    }
}
