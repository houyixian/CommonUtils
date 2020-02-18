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

    private let calendarView = AUCalendarView()

    let testView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        testView.backgroundColor = .red
        testView.auSet(cornerRadius: 20, shadowColor: .black, shadowOffset: CGSize(width: 10, height: 10), shadowOpacity: 1.0, shadowRadius: 10)
        view.addSubview(testView)
        testView.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
            m.width.height.equalTo(200)
        }
        let testString = "1860032718"
//        print(testString.)
//        let dashedLine = AUDashedLineView(frame: CGRect.zero, lineLength: 10, lineSpacing: 2, lineColor: .black, direction: .Vertical)
//        view.addSubview(dashedLine)
        // 水平方向的虚线约束
//        dashedLine.snp.makeConstraints { (m) in
//            m.center.equalToSuperview()
//            m.leading.trailing.equalToSuperview()
//            m.height.equalTo(2)
//        }
        // 竖直方向的虚线约束
//        dashedLine.snp.makeConstraints { (m) in
//            m.center.equalToSuperview()
//            m.top.bottom.equalToSuperview()
//            m.width.equalTo(2)
//        }
//        let dimmingView = AUHollowView(edge: UIEdgeInsets(top: 56, left: 7.5, bottom: view.bounds.height - 56 - 38, right: 7.5), hollowCornerRadius: 19)
//        dimmingView.minHeight = 38
//        dimmingView.backgroundColor = .black
//        dimmingView.alpha = 0.5
//        view.addSubview(dimmingView)
//        dimmingView.snp.makeConstraints { (m) in
//            m.edges.equalToSuperview()
//        }
//        view.insertSubview(calendarView, at: 0)
//        calendarView.snp.makeConstraints { (m) in
//            m.edges.equalToSuperview()
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        calendarView.scrollToBottom()
//        calendarView.isBeginEndlessScroll = true
//        testView.temporaryZoomInAnimation()
        testView.temporaryZoomOutAniamtion()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        show(message: "今天是个好日子今天是个好日子今天是个好日子今天是个好日子今天是个好日子今天是个好日子")
        testView.temporaryZoomOutAniamtion()
    }

    @IBAction func reloadCalendarView(_ sender: UIButton) {
        calendarView.reloadData()
    }

}

