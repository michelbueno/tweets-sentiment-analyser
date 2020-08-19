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
        var remoteServiceMock: RemoteServiceMock!
        var presenterMock: HomePresenterMock!

        beforeEach {
            remoteServiceMock = RemoteServiceMock()
            presenterMock = HomePresenterMock()

            sut = HomeInteractor()
            sut.remoteService = remoteServiceMock
            sut.presenter = presenterMock
        }

        describe("RemoteService") {
            context("fetchTweetsForUsername") {
                beforeEach {
                    remoteServiceMock.dataToReturn = "[{\"id_str\": \"1234567890\",\"text\": \"dummy text\"}]".data(using: .utf8)
                }

                it("calls RemoteService with correct params") {
                    sut.fetchTweetsFor(username: "someUserName")

                    let expectedURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=someUserName"
                    let expectedAuthHeader = HTTPHeader(name: "Authorization", value: "Bearer AAAAAAAAAAAAAAAAAAAAACePGwEAAAAAKz0vO7llEv6OT2m6HHujVXuJQPc%3DP7KXorCKshg4c8GeYEd47ywLzilKDxiKMg9ZiT3PcrgMptK6ai")

                    expect(remoteServiceMock.didCallGet).to(beTrue())
                    expect(remoteServiceMock.lastUrlCalled?.absoluteString).to(equal(expectedURL))
                    expect(remoteServiceMock.lastHeadersCalled).to(contain(expectedAuthHeader))
                }

                it("calls presenter to show tweets list with parsed tweets when request succeeds") {
                    sut.fetchTweetsFor(username: "someUserName")

                    expect(presenterMock.didCallLoadTweetsList).to(beTrue())
                    expect(presenterMock.lastListCalled).toNot(beNil())
                    expect(presenterMock.lastListCalled?.count).to(equal(1))
                    expect(presenterMock.lastListCalled?.first?.text).to(equal("dummy text"))
                    expect(presenterMock.lastListCalled?.first?.id).to(equal("1234567890"))
                }

                it("calls presenter to show error message when request fails") {
                    remoteServiceMock.returnError = true
                    sut.fetchTweetsFor(username: "someUserName")

                    expect(presenterMock.didCallShowError).to(beTrue())
                }
            }
        }
    }
}