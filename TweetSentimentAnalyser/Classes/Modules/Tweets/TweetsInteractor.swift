//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol TweetsInteractorType {
    var presenter: TweetsPresenterType? { get set }
    var tweetService: TweetServiceType? { get set }
    func fetchTweetsFor(_ username: String)
}

class TweetsInteractor: TweetsInteractorType {
    var presenter: TweetsPresenterType?
    var tweetService: TweetServiceType?
    var sentimentService: SentimentScoreServiceType?

    func fetchTweetsFor(_ username: String) {
        tweetService?.fetchTweetsTextFor(username: username, onSuccess: { tweetsList in
            self.presenter?.loadTweets(tweetsList)
        }, onFailure: {
            self.presenter?.failedToFetchTweets()
        })
    }
}