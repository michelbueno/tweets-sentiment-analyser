//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol HomeWireframeType {
    var tweetsWireframe: TweetsWireframeType? { get set }
    func createModule() -> UINavigationController
    func navigateToTweetsList(with username: String)
}

class HomeWireframe: HomeWireframeType {
    var tweetsWireframe: TweetsWireframeType?
    var navigationController: UINavigationController?

    func createModule() -> UINavigationController {
        let homeWireframe = self
        let tweetsWireframe = TweetsWireframe()
        homeWireframe.tweetsWireframe = tweetsWireframe

        let presenter = HomePresenter()
        presenter.wireframe = homeWireframe

        let viewController = HomeViewController()
        viewController.presenter = presenter
        presenter.view = viewController

        navigationController = UINavigationController(rootViewController: viewController)

        return navigationController!
    }

    func navigateToTweetsList(with username: String) {
        guard let tweetsListViewController = tweetsWireframe?.createModule(with: username) else {
            fatalError("Failed to create Tweets module")
        }

        navigationController?.pushViewController(tweetsListViewController, animated: true)
    }

}
