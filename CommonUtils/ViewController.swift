//
//  ViewController.swift
//  CommonUtils
//
//  Created by 侯逸仙 on 2019/10/29.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit
import CommonUIKit
import SnapKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let dashedLine = HorizontalDashedLineView(frame: CGRect.zero, lineLength: 10, lineSpacing: 2, lineColor: .black)
        view.addSubview(dashedLine)
        dashedLine.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
            m.leading.trailing.equalToSuperview()
            m.height.equalTo(2)
        }
    }


}

