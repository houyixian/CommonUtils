//
//  GradientView.swift
//  CommonUIKit
//
//  Created by 侯逸仙 on 2019/11/5.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit

public enum GradientDirection {
    case TopToBottom
    case BottomToTop
    case LeftToRight
    case RightToLeft
    case TopLeftToBottomRight
    case BottomRightToTopLeft
    case BottomLeftToTopRight
    case TopRightToBottomLeft
}

public class GradientView: UIView {

    private let gradientLayer = CAGradientLayer()

    private var fromColor: UIColor
    private var toColor: UIColor
    private var direction: GradientDirection

    /// warning: 内部和外部均不应该调用此方法
    private override init(frame: CGRect) {
        self.fromColor = UIColor.white
        self.toColor = UIColor.white
        self.direction = .TopToBottom
        super.init(frame: frame)
    }
    public init(frame: CGRect, from: UIColor, to: UIColor, direction: GradientDirection = .TopToBottom) {
        self.fromColor = from
        self.toColor = to
        self.direction = direction
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.colors = [fromColor.cgColor,
                                toColor.cgColor]
        switch direction {
        case .TopToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .BottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        case .LeftToRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        case .RightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        case .TopLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        case .BottomRightToTopLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        case .TopRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        case .BottomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }
        gradientLayer.frame = bounds
        // 把渐变加到最底下
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
