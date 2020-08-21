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
            var homeWireframeMock: HomeWireframeMock!
            var homeViewControllerMock: HomeViewControllerMock!
            var sut: HomePresenter!

            beforeEach {
                homeWireframeMock = HomeWireframeMock()
                homeViewControllerMock = HomeViewControllerMock()
                sut = HomePresenter()
                sut.wireframe = homeWireframeMock
                sut.view = homeViewControllerMock
            }

            context("when analyze button is pressed"){
                it("uses wireframe to navigate to tweets list with username param") {
                    sut.onAnaliseButtonPressed(username: "someUsername")

                    expect(homeWireframeMock.didCallNavigateToTweetsList).to(beTrue())
                    expect(homeWireframeMock.lasUsernameCalled).to(equal("someUsername"))
                }
            }
        }
    }
}