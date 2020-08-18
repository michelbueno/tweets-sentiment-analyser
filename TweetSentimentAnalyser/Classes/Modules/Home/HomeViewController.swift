//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    unowned var homeView: HomeView { return self.view as! HomeView }
    unowned var analyseButton: UIButton { return homeView.analyzeButton }
    unowned var usernameTextField: UITextField { return homeView.usernameTextField }
    
    var presenter: HomePresenterType?

    override func loadView() {
        self.view = HomeView()
        self.analyseButton.addTarget(self, action: #selector(analiseButtonPressed), for: .touchUpInside)
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
