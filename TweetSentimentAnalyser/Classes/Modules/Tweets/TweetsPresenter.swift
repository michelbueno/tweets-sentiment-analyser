//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol TweetsPresenterType {
    var view: TweetsViewControllerType? { get set }
    var interactor: TweetsInteractorType? { get set }
    func loadView(with username: String)
    func loadTweets(_ tweetsList: [Tweet])
    func failedToFetchTweets()
    func viewWillDisplayCellForTweet(_: Tweet)
    func updateTweet(_: Tweet)
}

class TweetsPresenter: TweetsPresenterType {
    var view: TweetsViewControllerType?
    var interactor: TweetsInteractorType?

    func failedToFetchTweets() {
        view?.showError()
    }

    func loadTweets(_ tweetsList: [Tweet]) {
        view?.loadTweets(tweetsList)
    }

    func loadView(with username: String) {
        interactor?.fetchTweetsFor(username)
    }

    func viewWillDisplayCellForTweet(_ tweet: Tweet) {
        interactor?.getSentimentScoreForTweet(tweet)
    }

    func updateTweet(_ tweet: Tweet) {
        view?.updateTweet(tweet)
    }
}