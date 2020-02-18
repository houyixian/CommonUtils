//
//  AUDashedLineView.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2020/2/17.
//  Copyright © 2020 侯逸仙. All rights reserved.
//

import UIKit

public enum DashedLineDirection {
    case Horizontal
    case Vertical
}

public class AUDashedLineView: UIView {

    private let dashedLineShapeLayer = CAShapeLayer()

    private var lineLength: CGFloat
    private var lineSpacing: CGFloat
    private var lineColor: UIColor
    private var direction: DashedLineDirection

    /// warning: 内部和外部均不应该调用此方法
    private override init(frame: CGRect) {
        lineLength = 0
        lineSpacing = 0
        lineColor = UIColor.white
        direction = .Horizontal
        super.init(frame: frame)
    }
    /// 必须使用的初始化方法
    /// - Parameter frame: frame，不建议使用。建议使用自动高度来布局
    /// - Parameter lineLength: 每一小节线的长度
    /// - Parameter lineSpacing: 相邻两小节线之间的距离
    /// - Parameter lineColor: 线的颜色
    /// - Parameter direction: 虚线的方向，默认是水平的。支持水平和垂直。注意：水平和垂直情况下的自动布局约束有区别
    public init(frame: CGRect, lineLength: CGFloat, lineSpacing: CGFloat, lineColor: UIColor, direction: DashedLineDirection = .Horizontal) {
        self.lineLength = lineLength
        self.lineSpacing = lineSpacing
        self.lineColor = lineColor
        self.direction = direction
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        dashedLineShapeLayer.bounds = bounds
        if direction == .Horizontal {
            dashedLineShapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        } else {
            dashedLineShapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        }
        dashedLineShapeLayer.fillColor = UIColor.clear.cgColor
        // 设置虚线的颜色
        dashedLineShapeLayer.strokeColor = lineColor.cgColor
        // 设置虚线的宽度
        if direction == .Horizontal {
            dashedLineShapeLayer.lineWidth = bounds.height
        } else {
            dashedLineShapeLayer.lineWidth = bounds.width
        }
        dashedLineShapeLayer.lineJoin = .round
        // 设置线宽和线间距
        dashedLineShapeLayer.lineDashPattern = [NSNumber(value:
            Float(lineLength)), NSNumber(value: Float(lineSpacing))]
        // 设置路径
        let path = CGMutablePath()
        if direction == .Horizontal {
            path.move(to: CGPoint(x: 0, y: bounds.height / 2))
            path.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 2))
        } else {
            path.move(to: CGPoint(x: bounds.width / 2, y: 0))
            path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height))
        }
        dashedLineShapeLayer.path = path
        // 把虚线加到最底下
        layer.insertSublayer(dashedLineShapeLayer, at: 0)
    }
}
