//
//  Extension+UIViewController.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2019/11/11.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    public func show(message: String) {
        let toastView = AUToastView(style: .normal, message: message)
        view.addSubview(toastView)
        toastView.snp.makeConstraints { (m) in
            m.leading.greaterThanOrEqualToSuperview().offset(15)
            m.trailing.lessThanOrEqualToSuperview().offset(-15)
            m.top.greaterThanOrEqualToSuperview().offset(15)
            m.bottom.lessThanOrEqualToSuperview().offset(-15)
            m.centerX.equalToSuperview()
            m.centerY.equalToSuperview().offset(20)
        }
        view.layoutIfNeeded()
        toastView.snp.updateConstraints { (m) in
            m.centerY.equalToSuperview()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            toastView.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 1.5, options: .curveEaseInOut, animations: {
                toastView.alpha = 0
            }) { (_) in
                toastView.removeFromSuperview()
            }
        }
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    /*
     1.如果想要禁用整个navigationController的右滑返回手势，
     只需要调用一次disableBackSwipeGesture()即可。
     2.如果想要禁用navigationController的vc栈中的某一个vc的右滑返回手势，
     则在该vc的viewDidAppear中加入disableBackSwipeGesture()，
     在viewWillDisapper中加入enableBackSwipeGesture()即可.
     */
    public func disableBackSwipeGesture() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    public func enableBackSwipeGesture() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

