//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class TweetsPresenterTest: QuickSpec {
    override func spec() {
        describe("TweetsPresenter") {
            var sut: TweetsPresenter!
            var viewMock: TweetsViewControllerMock!
            var interactorMock: TweetsInteractorMock!

            beforeEach {
                viewMock = TweetsViewControllerMock()
                interactorMock = TweetsInteractorMock()
                sut = TweetsPresenter()
                sut.view = viewMock
                sut.interactor = interactorMock
            }

            it("uses interactor to fetch tweets for given username") {
                sut.loadView(with: "username")

                expect(interactorMock.didCallFetchTweets).to(beTrue())
                expect(interactorMock.lastUsernameCalled).to(equal("username"))
            }

            it("tells view to show error when failedToFetchTweets is called") {
                sut.failedToFetchTweets()

                expect(viewMock.didCallShowError).to(beTrue())
            }

            it("tells view show tweets passing a list a tweets") {
                sut.showTweets(["a tweet"])

                expect(viewMock.didCallLoadTweets).to(beTrue())
                expect(viewMock.lastListCalled).toNot(beNil())
                expect(viewMock.lastListCalled?.first).to(equal("a tweet"))
            }
        }
    }
}