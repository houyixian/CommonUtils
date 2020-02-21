//
//  RedViewController.swift
//  CommonUtils
//
//  Created by 侯逸仙 on 2020/2/20.
//  Copyright © 2020 侯逸仙. All rights reserved.
//

import UIKit

class RedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(BlueViewController(), animated: true)
    }

}
