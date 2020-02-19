//
//  UIView+Blur.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2020/2/17.
//  Copyright © 2020 侯逸仙. All rights reserved.
//

import UIKit
import SnapKit

public enum AUMoveDirection {
    case up
    case down
    case left
    case right
}

extension UIView {
    /// 增加简单的模糊效果
    /// - Parameter effect: 视觉效果，UIVisualEffect类型
    public final func addSimpleBlur(effect: UIVisualEffect?) {
        let visualEffectView = UIVisualEffectView(effect: effect)
        addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }

    /// 设置圆角
    /// - Parameter radius: 圆角半径
    public final func auSet(cornerRadius radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }

    /// 设置阴影
    /// - Parameter color: 阴影的颜色
    /// - Parameter offset: 阴影的偏移量
    /// - Parameter opacity: 阴影的透明度
    /// - Parameter radius: 阴影的半径
    public final func auSetShadow(color: UIColor, offset: CGSize, opacity: Float, radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }

    /// 设置圆角和阴影
    /// - Parameter cornerRadius: 圆角半径
    /// - Parameter shadowColor: 阴影的颜色
    /// - Parameter shadowOffset: 阴影的偏移量
    /// - Parameter shadowOpacity: 阴影的透明度
    /// - Parameter shadowRadius: 阴影的半径
    public final func auSet(cornerRadius: CGFloat, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}

extension UIView {
    /// 放大一下视图，最后会恢复原样
    public func temporaryZoomInAnimation() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (_) in
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }

    /// 缩小一下视图，最后会恢复原样
    public func temporaryZoomOutAniamtion() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (_) in
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }

    /// 让视图简单的移动
    /// - Parameter distance: 移动距离
    /// - Parameter direction: 移动方向，支持上下左右四个方向
    /// - Parameter duration: 动画时间
    public func simple(move distance: CGFloat, to direction: AUMoveDirection, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else {
                return
            }
            switch direction {
            case .up:
                self.center.y -= distance
            case .down:
                self.center.y += distance
            case .left:
                self.center.x -= distance
            case .right:
                self.center.x += distance
            }
        }
    }
}
