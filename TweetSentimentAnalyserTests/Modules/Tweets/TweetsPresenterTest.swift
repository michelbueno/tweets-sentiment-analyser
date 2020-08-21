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
            var dummyTweet: Tweet!

            beforeEach {
                viewMock = TweetsViewControllerMock()
                interactorMock = TweetsInteractorMock()
                sut = TweetsPresenter()
                sut.view = viewMock
                sut.interactor = interactorMock
                dummyTweet = Tweet()
                dummyTweet.text = "a tweet"
            }

            it("uses interactor to fetch tweets for given username on loadView") {
                sut.loadView(with: "username")

                expect(interactorMock.didCallFetchTweets).to(beTrue())
                expect(interactorMock.lastUsernameCalled).to(equal("username"))
            }

            it("tells view to show error when failedToFetchTweets is called") {
                sut.failedToFetchTweets()

                expect(viewMock.didCallShowError).to(beTrue())
            }

            it("tells view show tweets passing a list a tweets") {
                sut.loadTweets([dummyTweet])

                expect(viewMock.didCallLoadTweets).to(beTrue())
                expect(viewMock.lastListCalled).toNot(beNil())
            }

            it("calls interactor to get sentiment score on viewWillDisplayCellForTweet") {
                sut.viewWillDisplayCellForTweet(dummyTweet)

                expect(interactorMock.didCallGetSentimentScoreForTweet)
                expect(interactorMock.didCallGetSentimentScoreForTweet).to(beTrue())
            }

            it("calls view to update tweet on updateTweet") {
                sut.updateTweet(dummyTweet)

                expect(viewMock.didCallUpdateTweet).to(beTrue())
                expect(viewMock.lastTweetCalled).toNot(beNil())
                expect(viewMock.lastTweetCalled?.text).to(equal("a tweet"))
            }

            it("calls view to set unknown state on failedToGetSentimentScoreForTweet") {
                sut.failedToGetSentimentScoreForTweet(dummyTweet)

                expect(viewMock.didCallSetUnknownScore).to(beTrue())
                expect(viewMock.lastTweetCalledBySetUnknownScore).toNot(beNil())
                expect(viewMock.lastTweetCalledBySetUnknownScore?.text).to(equal("a tweet"))
            }
        }
    }
}