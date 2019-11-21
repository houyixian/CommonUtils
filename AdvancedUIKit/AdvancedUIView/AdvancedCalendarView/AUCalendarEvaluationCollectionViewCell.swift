//
//  AKCalendarEvaluationCollectionViewCell.swift
//  iLifeKit
//
//  Created by 侯逸仙 on 2019/11/19.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit
import SnapKit
class AUCalendarEvaluationCollectionViewCell: UICollectionViewCell {
    static let ReuseIdentifier = "AUCalendarEvaluationCollectionViewCell"

    public var day: Int = 1 {
        didSet {
            if day > 0 {
                dayLabel.text = "\(day)"
                evaluationView.backgroundColor = .red
            } else {
                dayLabel.text = ""
                evaluationView.backgroundColor = .clear
            }
        }
    }

    private lazy var evaluationView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.black
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(evaluationView)
        evaluationView.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(5)
            m.trailing.equalToSuperview().offset(-5)
            m.top.equalToSuperview().offset(5)
            m.bottom.equalToSuperview().offset(-5)
        }
        evaluationView.backgroundColor = .red
        evaluationView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
