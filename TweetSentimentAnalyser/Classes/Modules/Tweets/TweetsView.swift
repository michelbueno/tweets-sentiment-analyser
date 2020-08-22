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
        tableView.isHidden = true
        return tableView
    }()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.isHidden = true
        indicator.style = .large
        return indicator
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    func setupUI() {
        self.setSubviewForAutoLayout(self.tweetsTableView)
        self.backgroundColor = .darkGray
        self.tweetsTableView.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.center.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }

        self.setSubviewForAutoLayout(errorLabel)
        self.errorLabel.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        self.setSubviewForAutoLayout(activityIndicator)
        self.activityIndicator.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.center.equalToSuperview()
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
