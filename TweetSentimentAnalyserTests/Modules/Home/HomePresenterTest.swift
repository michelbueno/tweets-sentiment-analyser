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
            var homeInteractorMock: HomeInteractorMock!
            var homeViewControllerMock: HomeViewControllerMock!
            var sut: HomePresenter!

            beforeEach {
                homeRouterMock = HomeRouterMock()
                homeInteractorMock = HomeInteractorMock()
                homeViewControllerMock = HomeViewControllerMock()
                sut = HomePresenter()
                sut.router = homeRouterMock
                sut.interactor = homeInteractorMock
                sut.view = homeViewControllerMock
            }

            it("calls interactor to search for given username") {
                sut.onAnaliseButtonPressed(username: "someUsername")

                expect(homeInteractorMock.didCallFetchInfo).to(beTrue())
                expect(homeInteractorMock.lastUsernameCalled).to(equal("someUsername"))
            }

            it("tells view show error message when fetch tweets fails") {
                sut.showError()

                expect(homeViewControllerMock.didCallShowErrorMessage).to(beTrue())
            }

            it("uses router to navigate to tweets list") {
                let tweet = Tweet()
                tweet.text = "dummy text"
                tweet.sentimentScore = 0.3
                sut.loadTweetsList(with: [tweet])

                expect(homeRouterMock.didCallPushToTweetsList).to(beTrue())
                expect(homeRouterMock.lastListCalled).toNot(beNil())
                expect(homeRouterMock.lastListCalled?.first?.text).to(equal("dummy text"))
                expect(homeRouterMock.lastListCalled?.first?.sentimentScore).to(equal(0.3))
            }
        }
    }
}