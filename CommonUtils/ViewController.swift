//
//  ViewController.swift
//  CommonUtils
//
//  Created by 侯逸仙 on 2019/10/29.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit
import AdvancedUIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dashedLine = AUHorizontalDashedLineView(frame: CGRect.zero, lineLength: 10, lineSpacing: 2, lineColor: .black)
        view.addSubview(dashedLine)
        dashedLine.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
            m.leading.trailing.equalToSuperview()
            m.height.equalTo(2)
        }
        let dimmingView = AUHollowView(edge: UIEdgeInsets(top: 56, left: 7.5, bottom: view.bounds.height - 56 - 38, right: 7.5), hollowCornerRadius: 19)
        dimmingView.minHeight = 38
        dimmingView.backgroundColor = .black
        dimmingView.alpha = 0.5
        view.addSubview(dimmingView)
        dimmingView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        show(message: "今天是个好日子今天是个好日子今天是个好日子今天是个好日子今天是个好日子今天是个好日子")
    }


}

