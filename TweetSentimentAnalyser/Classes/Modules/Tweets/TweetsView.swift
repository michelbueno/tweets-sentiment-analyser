//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public final class TweetsView: UIView {
    public let dummyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.text = "This is the Tweets View"
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviewForAutoLayout(self.dummyLabel)
        self.backgroundColor = UIColor.darkGray
        self.dummyLabel.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(40.0)
            make.trailing.equalToSuperview().inset(40.0)
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}