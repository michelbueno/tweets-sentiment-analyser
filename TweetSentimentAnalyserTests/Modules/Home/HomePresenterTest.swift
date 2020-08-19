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
            var sut: HomePresenter!

            beforeEach {
                homeRouterMock = HomeRouterMock()
                homeInteractorMock = HomeInteractorMock()
                sut = HomePresenter()
                sut.router = homeRouterMock
                sut.interactor = homeInteractorMock
            }

            it("calls interactor to search for given username") {
                sut.onAnaliseButtonPressed(username: "someUsername")

                expect(homeInteractorMock.didCallFetchInfo).to(beTrue())
                expect(homeInteractorMock.lastUsernameCalled).to(equal("someUsername"))
            }
        }
    }
}