//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class TweetsInteractorMock: TweetsInteractorType {
    var presenter: TweetsPresenterType?
    var tweetService: TweetServiceType?

    var didCallFetchTweets = false
    var lastUsernameCalled: String?

    func fetchTweetsFor(_ username: String) {
        didCallFetchTweets = true
        lastUsernameCalled = username
    }
}