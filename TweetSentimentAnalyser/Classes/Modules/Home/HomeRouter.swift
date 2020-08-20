//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouterType {
    var tweetsRouter: TweetsRouterType? { get set }
    func createModule() -> UINavigationController
    func navigateToTweetsList(with username: String)
}

class HomeRouter: HomeRouterType {
    var tweetsRouter: TweetsRouterType?
    var navigationController: UINavigationController?

    func createModule() -> UINavigationController {
        let homeRouter = self
        let tweetsRouter = TweetsRouter()
        homeRouter.tweetsRouter = tweetsRouter

        let presenter = HomePresenter()
        presenter.router = homeRouter

        let viewController = HomeViewController()
        viewController.presenter = presenter
        presenter.view = viewController

        navigationController = UINavigationController(rootViewController: viewController)

        return navigationController!
    }

    func navigateToTweetsList(with username: String) {
        guard let tweetsListViewController = tweetsRouter?.createModule(with: username) else {
            fatalError("Failed to create Tweets module")
        }

        navigationController?.pushViewController(tweetsListViewController, animated: true)
    }

}
