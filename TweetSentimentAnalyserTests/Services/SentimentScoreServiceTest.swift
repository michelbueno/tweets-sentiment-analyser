//
// Created by Michel Bueno on 19/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class SentimentScoreServiceTest: QuickSpec {
    override func spec() {
        describe("SentimentScoreService") {
            var sut: SentimentScoreService!
            var remoteServiceMock: RemoteServiceMock!

            beforeEach {
                remoteServiceMock = RemoteServiceMock()
                remoteServiceMock.dataToReturn = "{\"documentSentiment\": {\"score\": -0.2}}".data(using: .utf8)
                sut = SentimentScoreService()
                sut.remoteService = remoteServiceMock
            }

            it("uses RemoteService post to fetchSentimentScore") {
                sut.fetchSentimentScore(for: "dummy text", onSuccess: { _ in } , onFailure: {})

                expect(remoteServiceMock.didCallPost).to(beTrue())
            }

            it("uses correct url to fetch sentiment score") {
                let expectedUrl = "https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyBzk0lW8fgTxmcngQwAkAtHQli8QofFjSo"
                sut.fetchSentimentScore(for: "dummy text", onSuccess: { _ in } , onFailure: {})

                expect(remoteServiceMock.lastUrlCalled?.absoluteString).to(equal(expectedUrl))
            }

            it("sends correct payload on request to fetch sentiment score") {
                let expectedPayload: [String: Any] = [
                    "document" : [
                        "type":"PLAIN_TEXT",
                        "content":"dummy text"
                    ],
                    "encodingType": "UTF8"
                ]
                sut.fetchSentimentScore(for: "dummy text", onSuccess: { _ in } , onFailure: {})

                let param = remoteServiceMock.lastParametersCalled
                expect(param).toNot(beNil())
            }

            it("calls onSuccess with a valid score when request succeeds") {
                var didCallOnSuccess = false
                var parsedScore: Double?
                sut.fetchSentimentScore(for: "dummy text",
                        onSuccess: { score in
                            didCallOnSuccess = true
                            parsedScore = score
                        }, onFailure: {}
                )

                expect(didCallOnSuccess).to(beTrue())
                expect(parsedScore).to(equal(-0.2))
            }

            it("calls onFailure when remote service fails") {
                remoteServiceMock.returnError = true
                var didCallOnFailure = false

                sut.fetchSentimentScore(for: "dummy text", onSuccess: { _ in }, onFailure:{
                    didCallOnFailure = true
                })

                expect(didCallOnFailure).to(beTrue())
            }

            it("calls onFailure when it cannot parse sentiment score") {
                remoteServiceMock.returnError = false
                remoteServiceMock.dataToReturn = "{\"invalidObject\": {\"invalidField\": \"invalidValue\"}}".data(using: .utf8)

                var didCallOnFailure = false

                sut.fetchSentimentScore(for: "dummy text", onSuccess: { _ in }, onFailure:{
                    didCallOnFailure = true
                })

                expect(didCallOnFailure).to(beTrue())
            }
        }
    }
}