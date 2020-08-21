//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class TweetsPresenterMock: TweetsPresenterType {
    var view: TweetsViewControllerType?
    var interactor: TweetsInteractorType?

    var didCallLoadView = false
    var lastUsernameCalled: String?
    var didCallShowTweets = false
    var lastTweetsListCalled: [Tweet]?
    var didCallFailedToFetchTweets = false
    var didCallViewWillDisplayCellForTweet = false
    var lastTweetCalledByWillDisplayCell: Tweet?
    var didCallUpdateTweet = false
    var lastTweetCalledByUpdateTweet: Tweet?
    var didCallFailedToGetSentimentScoreForTweet = false
    var lastTweeCalledByFailedToGetSentimentScore: Tweet?

    func loadView(with username: String) {
        didCallLoadView = true
        lastUsernameCalled = username
    }

    func loadTweets(_ tweetsList: [Tweet]) {
        didCallShowTweets = true
        lastTweetsListCalled = tweetsList
    }

    func failedToFetchTweets() {
        didCallFailedToFetchTweets = true
    }

    func viewWillDisplayCellForTweet(_ tweet: Tweet) {
        didCallViewWillDisplayCellForTweet = true
        lastTweetCalledByWillDisplayCell = tweet
    }

    func updateTweet(_ tweet: Tweet) {
        didCallUpdateTweet = true
        lastTweetCalledByUpdateTweet = tweet
    }

    func failedToGetSentimentScoreForTweet(_ tweet: Tweet) {
        didCallFailedToGetSentimentScoreForTweet = true
        lastTweeCalledByFailedToGetSentimentScore = tweet
    }
}