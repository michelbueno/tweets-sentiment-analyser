//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

@testable import TweetSentimentAnalyser

class TweetsRouterMock: TweetsRouterType {
    var didCallCreateModule = false
    var lastUsernameCalled: String?

    func createModule(with username: String) -> TweetsViewController {
        didCallCreateModule = true
        lastUsernameCalled = username

        return TweetsViewController()
    }


}