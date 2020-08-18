//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol TweetsViewControllerType: class {
    func showTweets()
    func showError()
}

class TweetsViewController: UIViewController, TweetsViewControllerType {
    var presenter: TweetsPresenterType?
    var username: String?

    override func loadView() {
        self.view = TweetsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        presenter?.loadTweetsFor(username!)
//    }

    func showError() {

    }

    func showTweets() {

    }
}