//
//  MyCollection.swift
//  AdvancedUIKit
//
//  Created by 侯逸仙 on 2019/11/20.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit

class MyCollection: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()

        print(self.subviews.count)
        print("123123123")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
