//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

@testable import TweetSentimentAnalyser

class HomeRouterMock: HomeRouterType {
    var tweetsRouter: TweetsRouterType?
    var didCallCreateModule = false
    var didCallPushToTweetsList = false
    var lastListCalled: [Tweet]?

    func createModule() -> UINavigationController {
        didCallCreateModule = true
        return UINavigationController()
    }

    func showTweetList(with tweets: [Tweet]) {
        didCallPushToTweetsList = true
        lastListCalled = tweets
    }
}
