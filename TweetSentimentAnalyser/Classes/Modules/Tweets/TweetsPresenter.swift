//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol TweetsPresenterType {
    var view: TweetsViewControllerType? { get set }
    var interactor: TweetsInteractorType? { get set }
    func loadView(with username: String)
    func showTweets(_ tweetsList: [String])
    func failedToFetchTweets()
}

class TweetsPresenter: TweetsPresenterType {
    var view: TweetsViewControllerType?
    var interactor: TweetsInteractorType?

    func failedToFetchTweets() {
        view?.showError()
    }

    func showTweets(_ tweetsList: [String]) {
        view?.loadTweets(tweetsList)
    }

    func loadView(with username: String) {
        interactor?.fetchTweetsFor(username)
    }


}