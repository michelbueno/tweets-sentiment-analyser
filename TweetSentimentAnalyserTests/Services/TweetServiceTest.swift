//
// Created by Michel Bueno on 19/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class TweetServiceTest: QuickSpec {
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

            it("uses correct params on url to fetch tweets for a given username") {
                sut.fetchTweets(forUsername: "someUsername", startingFrom: nil, onSuccess: { _ in}, onFailure: {})
                let expectedUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=someUsername&count=30"

                expect(remoteServiceMock.lastUrlCalled?.absoluteString).to(equal(expectedUrl))
            }
            it("uses sends 'max_id' url to fetch tweets for a given username when startingFrom is not nil") {
                sut.fetchTweets(forUsername: "someUsername", startingFrom: "123456", onSuccess: { _ in}, onFailure: {})
                let expectedUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=someUsername&count=30&max_id=123456"

                expect(remoteServiceMock.lastUrlCalled?.absoluteString).to(equal(expectedUrl))
            }

            it("sends authorization header with Bearer token") {
                let expectedTokenValue = "Bearer AAAAAAAAAAAAAAAAAAAAACePGwEAAAAAKz0vO7llEv6OT2m6HHujVXuJQPc%3DP7KXorCKshg4c8GeYEd47ywLzilKDxiKMg9ZiT3PcrgMptK6ai"
                sut.fetchTweets(forUsername: "someUsername", startingFrom: nil, onSuccess: { _ in}, onFailure: {})

                expect(remoteServiceMock.lastHeadersCalled).toNot(beNil())
                expect(remoteServiceMock.lastHeadersCalled?.value(for: "Authorization")).to(equal(expectedTokenValue))
            }

            it("calls onFailure when remote service fails") {
                remoteServiceMock.returnError = true
                var didCallOnFailure = false

                sut.fetchTweets(forUsername: "someUsername", startingFrom: nil, onSuccess: { _ in }, onFailure: {
                    didCallOnFailure = true
                })

                expect(didCallOnFailure).to(beTrue())
            }

            it("call onSuccess with a valid text array when request succeeds") {
                var returnedTweeList: [Tweet]?
                sut.fetchTweets(forUsername: "someUsername", startingFrom: nil, onSuccess: { tweetList in
                    returnedTweeList = tweetList
                }, onFailure: {})

                expect(returnedTweeList).toNot(beNil())
                expect(returnedTweeList?.count).to(equal(1))
                expect(returnedTweeList?.first?.text).to(equal("dummy text"))

            }
        }
    }
}
