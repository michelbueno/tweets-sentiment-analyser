//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouterType {
    var tweetsRouter: TweetsRouterType? { get set }
    func createModule() -> UINavigationController
    func pushToTweetsList(with username: String)
}

class HomeRouter: HomeRouterType {
    var tweetsRouter: TweetsRouterType?
    var navigationController: UINavigationController?

    func createModule() -> UINavigationController {
        let viewController = HomeViewController()
        viewController.presenter = HomePresenter()
        viewController.presenter?.router = self
        viewController.presenter?.router?.tweetsRouter = TweetsRouter()
        navigationController = UINavigationController(rootViewController: viewController)

        return navigationController!
    }

    func pushToTweetsList(with username: String) {
        guard let tweetsListViewController = tweetsRouter?.createModule(with: username) else {
            fatalError("Failed to create Tweets module")
        }

        navigationController?.pushViewController(tweetsListViewController, animated: true)
    }

}