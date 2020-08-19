//
// Created by Michel Bueno on 19/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class HomeViewControllerMock: HomeViewControllerType {
    var didCallShowErrorMessage = false

    func showErrorMessage() {
        didCallShowErrorMessage = true
    }
}