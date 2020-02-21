//
//  BlueViewController.swift
//  CommonUtils
//
//  Created by 侯逸仙 on 2020/2/20.
//  Copyright © 2020 侯逸仙. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(GreenViewController(), animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        disableBackSwipeGesture()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        enableBackSwipeGesture()
    }

}
