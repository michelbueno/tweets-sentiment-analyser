//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewControllerType {
    var presenter: HomePresenterType? { get set }
    func showErrorMessage()
}

class HomeViewController: UIViewController {
    unowned var homeView: HomeView { self.view as! HomeView }
    unowned var analyseButton: UIButton { homeView.analyzeButton }
    unowned var usernameTextField: UITextField { homeView.usernameTextField }
    
    var presenter: HomePresenterType?

    override func loadView() {
        self.view = HomeView()
        self.analyseButton.addTarget(self, action: #selector(analiseButtonPressed), for: .touchUpInside)
        self.usernameTextField.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.navigationItem.title = "Tweet Sentiment Analyser"
    }

    @objc private func analiseButtonPressed() {
        presenter?.onAnaliseButtonPressed(username: usernameTextField.text!)
    }
}

extension HomeViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HomeViewController: HomeViewControllerType {
    func showErrorMessage() {
        debugPrint("showErrorMessage called")
    }
}
