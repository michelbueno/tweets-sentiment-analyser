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
    var lastTweetsListCalled: [String]?
    var didCallFailedToFetchTweets = false

    func loadView(with username: String) {
        didCallLoadView = true
        lastUsernameCalled = username
    }

    func showTweets(_ tweetsList: [String]) {
        didCallShowTweets = true
        lastTweetsListCalled = tweetsList
    }

    func failedToFetchTweets() {
        didCallFailedToFetchTweets = true
    }
}