//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol TweetsInteractorType {
    var presenter: TweetsPresenterType? { get set }
    var tweetService: TweetServiceType? { get set }
    var sentimentScoreService: SentimentScoreServiceType? { get set }
    func fetchTweetsFor(_ username: String)
    func getSentimentScoreForTweet(_: Tweet)
}

class TweetsInteractor: TweetsInteractorType {
    var presenter: TweetsPresenterType?
    var tweetService: TweetServiceType?
    var sentimentScoreService: SentimentScoreServiceType?

    func fetchTweetsFor(_ username: String) {
        tweetService?.fetchTweetsTextFor(username: username, onSuccess: { [unowned self] tweetsList in
            self.presenter?.loadTweets(tweetsList)
        }, onFailure: {
            self.presenter?.failedToFetchTweets()
        })
    }

    func getSentimentScoreForTweet(_ tweet: Tweet) {
        sentimentScoreService?.fetchSentimentScore(for: tweet.text!, onSuccess: { [unowned self] sentimentScore in
            tweet.sentimentScore = sentimentScore
            self.presenter?.updateTweet(tweet)
        }, onFailure: {
            self.presenter?.failedToGetSentimentScoreForTweet(tweet)
        })
    }
}