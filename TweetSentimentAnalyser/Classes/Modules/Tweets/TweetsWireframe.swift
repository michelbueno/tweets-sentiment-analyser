//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol TweetsWireframeType {
    func createModule(with username: String) -> TweetsViewController
}

class TweetsWireframe: TweetsWireframeType {
    func createModule(with username: String) -> TweetsViewController {
        let presenter = TweetsPresenter()
        let interactor = TweetsInteractor()

        let remoteService  = RemoteService()
        let tweetService = TweetService()
        let sentimentScoreService = SentimentScoreService()

        tweetService.remoteService = remoteService
        sentimentScoreService.remoteService = remoteService
        interactor.tweetService = tweetService
        interactor.sentimentScoreService = sentimentScoreService

        presenter.interactor = interactor
        interactor.presenter = presenter

        let viewController = TweetsViewController()
        viewController.username = username

        viewController.presenter = presenter
        presenter.view = viewController

        return viewController
    }
}
