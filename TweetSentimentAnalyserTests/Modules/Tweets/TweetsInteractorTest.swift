//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire

@testable import TweetSentimentAnalyser

class TweetsInteractorTest: QuickSpec {
    override func spec() {
        var sut: TweetsInteractor!
        var tweetServiceMock: TweetServiceMock!
        var presenterMock: TweetsPresenterMock!

        describe("TweetInteractorTest") {
            beforeEach {
                tweetServiceMock = TweetServiceMock()
                tweetServiceMock.listToReturn = ["a tweet", "another tweet"]
                presenterMock = TweetsPresenterMock()

                sut = TweetsInteractor()
                sut.tweetService = tweetServiceMock
                sut.presenter = presenterMock
            }

            it("uses TweetService to fetch tweets text list with correct params") {
                sut.fetchTweetsFor("someUsername")

                expect(tweetServiceMock.didCallFetchTweetsText).to(beTrue())
                expect(tweetServiceMock.lastUsernameCalled).to(equal("someUsername"))
            }

            it("uses presenter to show error when tweet service fails") {
                tweetServiceMock.returnError = true

                sut.fetchTweetsFor("someUsername")

                expect(presenterMock.didCallFailedToFetchTweets).to(beTrue())
            }

            it("calls presenter with a list of tweets when request succeeds") {
                tweetServiceMock.listToReturn = ["a tweet"]

                sut.fetchTweetsFor("someUsername")

                expect(presenterMock.didCallShowTweets).to(beTrue())
            }


        }

    }
}