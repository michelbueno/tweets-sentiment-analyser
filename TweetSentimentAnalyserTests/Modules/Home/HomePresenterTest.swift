//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class HomePresenterTest: QuickSpec {
    override func spec() {
        describe("HomePresenter") {
            var homeRouterMock: HomeRouterMock!
            var sut: HomePresenter!

            beforeEach {
                homeRouterMock = HomeRouterMock()
                sut = HomePresenter()
                sut.router = homeRouterMock
            }

            it("calls router to push to Tweets list view controller when button analyse is pressed") {
                sut.onAnaliseButtonPressed(username: "someUsername")

                expect(homeRouterMock.didCallPushToTweetsList).to(beTrue())
                expect(homeRouterMock.lastUsernameCalled).to(equal("someUsername"))
            }
        }
    }
}