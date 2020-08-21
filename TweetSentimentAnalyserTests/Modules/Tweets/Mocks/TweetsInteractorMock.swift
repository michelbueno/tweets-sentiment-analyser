//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class TweetsInteractorMock: TweetsInteractorType {
    var presenter: TweetsPresenterType?
    var tweetService: TweetServiceType?
    var sentimentScoreService: SentimentScoreServiceType?
    var didCallFetchTweets = false
    var didCallGetSentimentScoreForTweet = false
    var lastTweetCalled: Tweet?
    var lastStartingFromCalled: String?
    var lastUsernameCalled: String?

    func fetchTweets(forUsername username: String, startingFrom tweetId: String?) {
        didCallFetchTweets = true
        lastUsernameCalled = username
    }

    func getSentimentScore(forTweet tweet: Tweet) {
        didCallGetSentimentScoreForTweet = true
        lastTweetCalled = tweet
    }
}