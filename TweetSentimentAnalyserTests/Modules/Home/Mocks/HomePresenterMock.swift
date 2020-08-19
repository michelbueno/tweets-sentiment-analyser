//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class HomePresenterMock: HomePresenterType {
    var router: HomeRouterType?
    var interactor: HomeInteractorType?
    var view: HomeViewControllerType?

    var didCallOnAnaliseButtonPressed = false
    var lastUsernameCalled: String?
    var didCallShowError = false
    var didCallLoadTweetsList = false
    var lastListCalled: [String]?

    func onAnaliseButtonPressed(username: String) {
        didCallOnAnaliseButtonPressed = true
        lastUsernameCalled = username
    }
    
    func showError() {
        didCallShowError = true
    }
    
    func loadTweetsList(with tweets: [String]) {
        didCallLoadTweetsList = true
        lastListCalled = tweets
    }
    
}
