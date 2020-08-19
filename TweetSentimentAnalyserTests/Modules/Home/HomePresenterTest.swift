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
                sut.loadTweetsList(with: ["dummy text"])

                expect(homeRouterMock.didCallPushToTweetsList).to(beTrue())
                expect(homeRouterMock.lastListCalled).toNot(beNil())
                expect(homeRouterMock.lastListCalled?.count).to(equal(1))
                expect(homeRouterMock.lastListCalled?.first).to(equal("dummy text"))
            }
        }
    }
}