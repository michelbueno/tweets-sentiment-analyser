//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

@testable import TweetSentimentAnalyser

class HomeWireframeMock: HomeWireframeType {
    var tweetsWireframe: TweetsWireframeType?

    var didCallCreateModule = false
    var didCallNavigateToTweetsList = false
    var lasUsernameCalled: String?

    func createModule() -> UINavigationController {
        didCallCreateModule = true
        return UINavigationController()
    }

    func navigateToTweetsList(with username: String) {
        didCallNavigateToTweetsList = true
        lasUsernameCalled = username
    }

}
