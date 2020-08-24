//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class TweetsViewControllerMock: TweetsViewControllerType {
    var presenter: TweetsPresenterType?

    var didCallLoadTweets = false
    var lastListCalled: [Tweet]?
    var didCallShowError = false
    var didCallUpdateTweet = false
    var lastTweetCalled: Tweet?

    func loadTweets(_ tweetsList: [Tweet]) {
        didCallLoadTweets = true
        lastListCalled = tweetsList
    }

    func showError() {
        didCallShowError = true
    }

    func updateTweet(_ tweet: Tweet) {
        didCallUpdateTweet = true
        lastTweetCalled = tweet
    }
}