//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol TweetsInteractorType {
    var presenter: TweetsPresenterType? { get set }
    var tweetService: TweetServiceType? { get set }
    var sentimentScoreService: SentimentScoreServiceType? { get set }
    func fetchTweets(forUsername username: String, startingFrom tweetId: String?)
    func getSentimentScore(forTweet tweet: Tweet)
}

class TweetsInteractor: TweetsInteractorType {
    var presenter: TweetsPresenterType?
    var tweetService: TweetServiceType?
    var sentimentScoreService: SentimentScoreServiceType?

    func fetchTweets(forUsername username: String, startingFrom tweetId: String?) {
        tweetService?.fetchTweets(forUsername: username, startingFrom: tweetId, onSuccess: { [unowned self] tweetsList in
            self.presenter?.loadTweets(tweetsList)
        }, onFailure: {
            self.presenter?.failedToFetchTweets()
        })
    }

    func getSentimentScore(forTweet tweet: Tweet) {
        sentimentScoreService?.fetchSentimentScore(forText: tweet.text!, onSuccess: { [unowned self] sentimentScore in
            tweet.sentimentScore = sentimentScore
            self.presenter?.updateTweet(tweet)
        }, onFailure: {
            self.presenter?.failedToGetSentimentScoreForTweet(tweet)
        })
    }
}