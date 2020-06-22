//
//  AULoadingView.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2020/6/22.
//  Copyright © 2020 侯逸仙. All rights reserved.
//

import UIKit

/// 加载视图的状态
public enum AULoadingViewState {
    // 加载中
    case loading
    // 呈现刷新视图
    case refresh
    // 正常展示内容
    case normal
}

public class AULoadingView: UIView {

    public var state: AULoadingViewState = .loading {
        didSet {
            switch state {
            case .normal:
                removeRefreshView()
                removeLoading()
            case .loading:
                showLoading()
            case .refresh:
                showRefreshView()
            }
        }
    }

    /// 加载视图所持有的耗时操作，比如网络请求、本地数据读取、IO操作等
    public var operation: (() -> ())?

    /// 加载视图的背景颜色
    public var loadingViewBackgroundColor: UIColor = .white

    /// 重新加载视图背景颜色
    public var refreshViewBackgroundColor: UIColor = .white

    /// 加载视图显示动画时间
    public var loadingViewShowDuration: Double = 0.3

    /// 加载视图消失动画时间
    public var loadingViewDismissDuration: Double = 0.3

    /// 重新加载视图显示动画时间
    public var refreshViewShowDuration: Double = 0.3

    /// 重新加载视图消失动画时间
    public var refreshViewDismissDuration: Double = 0.3

    /// 错误信息，调用方在加载失败时可选设置的提示信息
    public var errorMessage: String? {
        didSet {
            errorMessageLabel.text = errorMessage
        }
    }

    /// 加载视图，子类可重写，使用自己期望的加载视图
    public lazy var loadingView: UIView = {
        let view = UIView()
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        let leadingConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        view.backgroundColor = loadingViewBackgroundColor
        return view
    }()

    /// 加载视图开始进行异步操作
    public func beginLoading() {
        refreshAction()
    }

    @objc private func refreshAction() {
        showLoading()
        operation?()
    }

    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "网络错误"
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    /// 重新加载视图，子类可以重写，使用自己期望的重新加载视图
    public lazy var refreshView: UIView = {
        let view = UIView()
        let refreshButton = UIButton(type: .system)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.setTitle("重新加载", for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        view.addSubview(self.errorMessageLabel)
        view.addSubview(refreshButton)
        let labelCenterXConstraint = NSLayoutConstraint(item: self.errorMessageLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let labelLeadingConstraint = NSLayoutConstraint(item: self.errorMessageLabel, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: view, attribute: .leading, multiplier: 1, constant: 5)
        let labelTrailingConstraint = NSLayoutConstraint(item: self.errorMessageLabel, attribute: .trailing, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: view, attribute: .trailing, multiplier: 1, constant: -5)
        let labelBottomConstraint = NSLayoutConstraint(item: self.errorMessageLabel, attribute: .bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: refreshButton, attribute: .top, multiplier: 1, constant: -10)
        let centerXConstraint = NSLayoutConstraint(item: refreshButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: refreshButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addConstraints([centerXConstraint, centerYConstraint, labelCenterXConstraint, labelLeadingConstraint, labelTrailingConstraint, labelBottomConstraint])
        view.backgroundColor = refreshViewBackgroundColor
        return view
    }()

    private func showLoading() {
        addSubview(loadingView)
        bringSubviewToFront(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: loadingView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: loadingView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: loadingView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: loadingView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        UIView.animate(withDuration: loadingViewShowDuration, animations: {
            self.loadingView.alpha = 1
        }) { (_) in
            self.refreshView.removeFromSuperview()
        }
    }

    private func removeLoading() {
        UIView.animate(withDuration: loadingViewDismissDuration, animations: {
            self.loadingView.alpha = 0
        }) { (_) in
            self.loadingView.removeFromSuperview()
            self.loadingView.alpha = 1
        }
    }

    private func showRefreshView() {
        addSubview(refreshView)
        bringSubviewToFront(refreshView)
        refreshView.alpha = 0
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: refreshView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: refreshView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: refreshView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: refreshView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        UIView.animate(withDuration: refreshViewShowDuration, animations: {
            self.refreshView.alpha = 1
        }) { (_) in
            self.loadingView.removeFromSuperview()
        }
    }

    private func removeRefreshView() {
        UIView.animate(withDuration: refreshViewDismissDuration, animations: {
            self.refreshView.alpha = 0
        }) { (_) in
            self.refreshView.removeFromSuperview()
            self.refreshView.alpha = 1
        }
    }
}

