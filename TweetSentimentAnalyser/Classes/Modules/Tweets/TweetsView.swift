//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public final class TweetsView: UIView {

    let tweetsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .darkGray
        tableView.allowsSelection = false
        return tableView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviewForAutoLayout(self.tweetsTableView)
        self.backgroundColor = .darkGray
        self.tweetsTableView.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.center.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
