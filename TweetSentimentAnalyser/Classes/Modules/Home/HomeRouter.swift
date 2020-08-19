//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouterType {
    var tweetsRouter: TweetsRouterType? { get set }
    func createModule() -> UINavigationController
    func showTweetList(with tweets: [Tweet])
}

class HomeRouter: HomeRouterType {
    var tweetsRouter: TweetsRouterType?
    var navigationController: UINavigationController?

    func createModule() -> UINavigationController {
        let homeRouter = self
        let tweetsRouter = TweetsRouter()
        let remoteService = RemoteService()
        homeRouter.tweetsRouter = tweetsRouter
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        interactor.remoteService = remoteService
        presenter.interactor = interactor
        interactor.presenter = presenter

        let viewController = HomeViewController()
        viewController.presenter = presenter
        navigationController = UINavigationController(rootViewController: viewController)

        return navigationController!
    }

    func showTweetList(with tweets: [Tweet]) {
        guard let tweetsListViewController = tweetsRouter?.createModule(with: tweets) else {
            fatalError("Failed to create Tweets module")
        }

        navigationController?.pushViewController(tweetsListViewController, animated: true)
    }

}
