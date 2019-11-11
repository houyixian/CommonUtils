//
//  AUToastView.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2019/11/11.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit
import SnapKit
/// 只支持自动布局
public class AUToastView: UIView {

    public enum Style {
        case normal
        case error
    }

    private var style: Style

    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black
        label.numberOfLines = 0
        return label
    }()

    public init(style: Style, message: String) {
        self.style = style
        label.text = message
        super.init(frame: .zero)
        backgroundColor = .black
        addSubview(label)
        label.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(10)
            m.trailing.equalToSuperview().offset(-10)
            m.top.equalToSuperview().offset(10)
            m.bottom.equalToSuperview().offset(-10)
        }
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }


    private override init(frame: CGRect) {
        style = .normal
        super.init(frame: frame)
    }
    private init() {
        style = .normal
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
