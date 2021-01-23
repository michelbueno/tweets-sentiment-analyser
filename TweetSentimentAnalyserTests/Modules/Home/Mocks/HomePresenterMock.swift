//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class HomePresenterMock: HomePresenterType {
    var wireframe: HomeWireframeType?
    var view: HomeViewControllerType?

    var didCallOnAnaliseButtonPressed = false
    var lasUsernameCalled: String?

    func onAnaliseButtonPressed(username: String) {
        didCallOnAnaliseButtonPressed = true
        lasUsernameCalled = username
    }

}
