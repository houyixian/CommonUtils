//
//  HorizontalDashedLineView.swift
//  CommonUIKit
//
//  Created by 侯逸仙 on 2019/11/5.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit

public class HorizontalDashedLineView: UIView {

    private let dashedLineShapeLayer = CAShapeLayer()

    private var lineLength: CGFloat
    private var lineSpacing: CGFloat
    private var lineColor: UIColor

    /// warning: 内部和外部均不应该调用此方法
    private override init(frame: CGRect) {
        self.lineLength = 0
        self.lineSpacing = 0
        self.lineColor = UIColor.white
        super.init(frame: frame)
    }
    public init(frame: CGRect, lineLength: CGFloat, lineSpacing: CGFloat, lineColor: UIColor) {
        self.lineLength = lineLength
        self.lineSpacing = lineSpacing
        self.lineColor = lineColor
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        dashedLineShapeLayer.bounds = bounds
        dashedLineShapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height)
        dashedLineShapeLayer.fillColor = UIColor.clear.cgColor
        // 设置虚线的颜色
        dashedLineShapeLayer.strokeColor = lineColor.cgColor
        // 设置虚线的宽度
        dashedLineShapeLayer.lineWidth = bounds.height
        dashedLineShapeLayer.lineJoin = .round
        // 设置线宽和线间距
        dashedLineShapeLayer.lineDashPattern = [NSNumber(value:
            Float(lineLength)), NSNumber(value: Float(lineSpacing))]
        // 设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: bounds.height / 2))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 2))
        dashedLineShapeLayer.path = path
        // 把虚线加到最底下
        layer.insertSublayer(dashedLineShapeLayer, at: 0)
    }
}
