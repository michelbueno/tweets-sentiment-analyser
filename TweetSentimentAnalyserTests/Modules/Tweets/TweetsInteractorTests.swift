//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class TweetsInteractorTests: QuickSpec {
    override func spec() {
        describe("Tweets Interactor") {
            var tweetsPresenterMock: TweetsPresenterMock!
            var sut: TweetsInteractor!
            beforeEach {
                tweetsPresenterMock = TweetsPresenterMock()

                sut = TweetsInteractor()
                sut.presenter = tweetsPresenterMock
            }

            it("fetches tweets for the given username") {
                sut.fetchTweetsFor(username: "someUsername")
            }
        }
    }
}