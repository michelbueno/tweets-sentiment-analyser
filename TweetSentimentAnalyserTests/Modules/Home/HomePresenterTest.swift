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
            var homeViewControllerMock: HomeViewControllerMock!
            var sut: HomePresenter!

            beforeEach {
                homeRouterMock = HomeRouterMock()
                homeViewControllerMock = HomeViewControllerMock()
                sut = HomePresenter()
                sut.router = homeRouterMock
                sut.view = homeViewControllerMock
            }

            context("when analyze button is pressed"){
                it("uses router to navigate to tweets list with username param") {
                    sut.onAnaliseButtonPressed(username: "someUsername")

                    expect(homeRouterMock.didCallNavigateToTweetsList).to(beTrue())
                    expect(homeRouterMock.lasUsernameCalled).to(equal("someUsername"))
                }
            }
        }
    }
}