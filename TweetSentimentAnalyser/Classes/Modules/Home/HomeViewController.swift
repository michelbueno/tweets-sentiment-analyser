//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewControllerType {
    func showErrorMessage()
}

class HomeViewController: UIViewController {
    unowned var homeView: HomeView { return self.view as! HomeView }
    unowned var analyseButton: UIButton { return homeView.analyzeButton }
    unowned var usernameTextField: UITextField { return homeView.usernameTextField }
    
    var presenter: HomePresenterType?

    override func loadView() {
        self.view = HomeView()
        self.analyseButton.addTarget(self, action: #selector(analiseButtonPressed), for: .touchUpInside)
        self.usernameTextField.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
