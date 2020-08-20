//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol TweetsRouterType {
    func createModule(with username: String) -> TweetsViewController
}

class TweetsRouter: TweetsRouterType {
    func createModule(with username: String) -> TweetsViewController {
        let presenter = TweetsPresenter()
        let interactor = TweetsInteractor()

        let remoteService  = RemoteService()
        let tweetService = TweetService()

        tweetService.remoteService = remoteService
        interactor.tweetService = tweetService

        presenter.interactor = interactor
        interactor.presenter = presenter

        let viewController = TweetsViewController()
        viewController.username = username

        viewController.presenter = presenter
        presenter.view = viewController

        return viewController
    }
}