//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol TweetsPresenterType: class {
    var router: TweetsRouter? { get set }
    var view: TweetsViewControllerType? { get set }
    var interactor: TweetsInteractorType? { get set }

    func loadTweetsFor(_ username: String)
    func onTweetFetchSuccess()
    func onTweetFetchError()
}

class TweetsPresenter: TweetsPresenterType {
    weak var view: TweetsViewControllerType?
    var interactor: TweetsInteractorType?
    var router: TweetsRouter?

    func loadTweetsFor(_ username: String) {
        interactor?.fetchTweetsFor(username: username)
    }

    func onTweetFetchSuccess() {
        view?.showTweets()
    }

    func onTweetFetchError() {
        view?.showError()
    }
}

