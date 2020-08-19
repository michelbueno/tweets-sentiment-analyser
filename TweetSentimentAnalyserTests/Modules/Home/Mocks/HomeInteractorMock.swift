//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class HomeInteractorMock: HomeInteractorType {
    var tweetService: TweetServiceType?
    var presenter: HomePresenterType?

    var didCallFetchInfo = false
    var lastUsernameCalled: String?

    func fetchTweetsFor(username: String) {
        didCallFetchInfo = true
        lastUsernameCalled = username
    }
}
