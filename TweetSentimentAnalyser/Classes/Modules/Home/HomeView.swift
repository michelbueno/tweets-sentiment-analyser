//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import UIKit
import SnapKit

public final class HomeView: UIView {

    public let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "username"
        textField.textColor = UIColor.darkGray
        textField.minimumFontSize = 17.0
        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.returnKeyType = .done
        return textField
    }()

    public let welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Welcome to Tweet Sentiment Analyser!\nTo start, type a username to look up"
        return label
    }()

    public let analyzeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Analise", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        return button
    }()

    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.welcomeLabel, self.usernameTextField, self.analyzeButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10.0
        return stackView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviewForAutoLayout(self.stackView)
        self.backgroundColor = UIColor.darkGray
        self.stackView.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(40.0)
            make.trailing.equalToSuperview().inset(40.0)
        }

        self.usernameTextField.snp.makeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(self).multipliedBy(0.075)
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}