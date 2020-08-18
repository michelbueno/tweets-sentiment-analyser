//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class TweetsPresenterMock: TweetsPresenterType {
    var router: TweetsRouter?
    var view: TweetsViewControllerType?
    var interactor: TweetsInteractorType?

    var didCallLoadTweetsForUsername = false
    var lastUsernameCalled: String?
    var didCallLoadTweetsSuccess = false
    var didCallOnTweetFetchError = false

    func loadTweetsFor(_ username: String) {
        didCallLoadTweetsForUsername = true
        lastUsernameCalled = username
    }

    func onTweetFetchSuccess() {
        didCallLoadTweetsSuccess = true
    }

    func onTweetFetchError() {
        didCallOnTweetFetchError = true
    }
}