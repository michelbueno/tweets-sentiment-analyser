//
// Created by Michel Bueno on 19/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class TweeServiceTest: QuickSpec {
    override func spec() {
        describe("TweetService") {
            var sut: TweetService!
            var remoteServiceMock: RemoteServiceMock!

            beforeEach {
                remoteServiceMock = RemoteServiceMock()
                sut = TweetService()
                sut.remoteService = remoteServiceMock
                remoteServiceMock.dataToReturn = "[{\"id_str\": \"1234567890\",\"text\": \"dummy text\"}]".data(using: .utf8)
            }

            it("uses correct url to fetch tweets for a given username") {
                sut.fetchTweetsTextFor(username: "someUsername", onSuccess: { _ in}, onFailure: {})
                let expectedUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=someUsername"

                expect(remoteServiceMock.lastUrlCalled?.absoluteString).to(equal(expectedUrl))
            }

            it("sends authorization header with Bearer token") {
                let expectedTokenValue = "Bearer AAAAAAAAAAAAAAAAAAAAACePGwEAAAAAKz0vO7llEv6OT2m6HHujVXuJQPc%3DP7KXorCKshg4c8GeYEd47ywLzilKDxiKMg9ZiT3PcrgMptK6ai"
                sut.fetchTweetsTextFor(username: "someUsername", onSuccess: { _ in}, onFailure: {})

                expect(remoteServiceMock.lastHeadersCalled).toNot(beNil())
                expect(remoteServiceMock.lastHeadersCalled?.value(for: "Authorization")).to(equal(expectedTokenValue))
            }

            it("calls onFailure when remote service fails") {
                remoteServiceMock.returnError = true
                var didCallOnFailure = false

                sut.fetchTweetsTextFor(username: "someUsername", onSuccess: { _ in }, onFailure: {
                    didCallOnFailure = true
                })

                expect(didCallOnFailure).to(beTrue())
            }

            it("call onSuccess with a valid text array when request succeeds") {
                var returnedTweeList: [Tweet]?
                sut.fetchTweetsTextFor(username: "someUsername", onSuccess: { tweetList in
                    returnedTweeList = tweetList
                }, onFailure: {})

                expect(returnedTweeList).toNot(beNil())
                expect(returnedTweeList?.count).to(equal(1))
                expect(returnedTweeList?.first?.text).to(equal("dummy text"))

            }
        }
    }
}
