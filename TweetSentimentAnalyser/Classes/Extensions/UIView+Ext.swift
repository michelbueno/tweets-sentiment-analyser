//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import UIKit

public extension UIView {
    func setSubviewForAutoLayout(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
    }
}
