//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class TweetsViewControllerMock: TweetsViewControllerType {
    var didCallShowTweets = false
    var didCallShoError = false


    func showTweets() {
        didCallShowTweets = true
    }

    func showError() {
        didCallShoError = true
    }
}
