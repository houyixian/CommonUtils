//
//  AKCalendarSectionHeaderCollectionReusableView.swift
//  iLifeKit
//
//  Created by 侯逸仙 on 2019/11/19.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit

class AUCalendarSectionHeaderCollectionReusableView: UICollectionReusableView {
    static let ReuseIdentifier = "AKCalendarSectionHeaderCollectionReusableView"

    var title: String = "发生未知错误,无法显示标题" {
        didSet {
            titleLabel.text = title
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(15)
            m.centerY.equalToSuperview()
            m.trailing.lessThanOrEqualToSuperview().offset(-15)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
