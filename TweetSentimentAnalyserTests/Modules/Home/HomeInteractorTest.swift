//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire

@testable import TweetSentimentAnalyser

class HomeInteractorTest: QuickSpec {
    override func spec() {
        var sut: HomeInteractor!
        var tweetServiceMock: TweetServiceMock!
        var presenterMock: HomePresenterMock!

        describe("HomeInteractor") {
            beforeEach {
                tweetServiceMock = TweetServiceMock()
                tweetServiceMock.listToReturn = ["a tweet", "another tweet"]
                presenterMock = HomePresenterMock()

                sut = HomeInteractor()
                sut.tweetService = tweetServiceMock
                sut.presenter = presenterMock
            }

            it("uses TweetService to fetch tweets text list with correct params") {
                sut.fetchTweetsFor(username: "someUsername")

                expect(tweetServiceMock.didCallFetchTweetsText).to(beTrue())
                expect(tweetServiceMock.lastUsernameCalled).to(equal("someUsername"))
            }

            it("uses presenter to show error when tweet service fails") {
                tweetServiceMock.returnError = true

                sut.fetchTweetsFor(username: "someUsername")

                expect(presenterMock.didCallShowError).to(beTrue())
            }
        }

    }
}