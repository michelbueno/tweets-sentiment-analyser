//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TweetsTableViewCell: UITableViewCell {
    var label: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    var activityIndicator: UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.color = .lightGray
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    func setupUI() {
        self.backgroundColor = .darkGray

        self.contentView.addSubview(label)
        label.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.left.equalToSuperview().offset(64)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }

        self.contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.centerY.equalTo(self.contentView)
        }

        self.imageView?.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.centerY.equalTo(self.contentView)
        }
    }

    func configureUnknownSentimentScore() {
        self.activityIndicator.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureImageForSentimentScore(_ score: SentimentScore) {
        self.activityIndicator.isHidden = true

        switch score {
        case .sad:
            self.imageView?.image = UIImage(named: "sad")
        case .neutral:
            self.imageView?.image = UIImage(named: "neutral")
        case .happy:
            self.imageView?.image = UIImage(named: "happy")
        }
    }
}