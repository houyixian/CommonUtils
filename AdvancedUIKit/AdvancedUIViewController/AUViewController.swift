//
//  AUViewController.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2019/11/11.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit
import SnapKit

public enum AUViewControllerStatus {
    case normal
    case networkError
    case loading
}

public class AUViewController: UIViewController {

    /// 所有要展示的内容应该增加到contentView上，不要直接加到vc的view上
    public let contentView = UIView()

    public var status: AUViewControllerStatus = .normal {
        didSet {
            update(status: status)
        }
    }

    /// 该提示框是加载在页面上的，不会阻拦用户退出VC等
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        return activity
    }()

    private lazy var networkErrorView: UIView = {
        let view = UIView()
        // 展示网络错误的提示view，用户点击可以重新加载
        let button = UIButton()
        button.titleLabel?.text = "重新加载"
        view.addSubview(button)
        button.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
        }
        button.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        return view
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        view.addSubview(networkErrorView)
        networkErrorView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
        }
    }

}
// MARK: 子类应该重写的方法
extension AUViewController {

    /// 重新加载所有网络请求，假如有分页，则为重新请求第一页数据
    @objc public func reloadData() {}
}

// MARK: 辅助方法
extension AUViewController {
    private func update(status: AUViewControllerStatus) {
        switch status {
        case .normal:
            contentView.isHidden = false
            activityIndicatorView.isHidden = true
            networkErrorView.isHidden = true
        case .loading:
            activityIndicatorView.isHidden = false
            view.bringSubviewToFront(activityIndicatorView)
        case .networkError:
            contentView.isHidden = true
            activityIndicatorView.isHidden = true
            networkErrorView.isHidden = false
        }
    }
}

