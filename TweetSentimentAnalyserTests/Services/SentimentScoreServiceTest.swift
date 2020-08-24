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
                sut.fetchSentimentScore(forText: "dummy text", onSuccess: { _ in } , onFailure: {})

                expect(remoteServiceMock.didCallPost).to(beTrue())
            }

            it("uses correct url to fetch sentiment score") {
                let expectedUrl = "https://language.googleapis.com/v1/documents:analyzeSentiment?key=google_api_key_goes_here"
                sut.fetchSentimentScore(forText: "dummy text", onSuccess: { _ in } , onFailure: {})

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
                sut.fetchSentimentScore(forText: "dummy text", onSuccess: { _ in } , onFailure: {})

                let param = remoteServiceMock.lastParametersCalled
                expect(param).toNot(beNil())
                //TODO: test request params
            }

            it("calls onSuccess with a valid score when request succeeds") {
                var didCallOnSuccess = false
                var parsedScore: SentimentScore?
                sut.fetchSentimentScore(forText: "dummy text",
                        onSuccess: { score in
                            didCallOnSuccess = true
                            parsedScore = score
                        }, onFailure: {}
                )

                expect(didCallOnSuccess).to(beTrue())
                expect(parsedScore).to(equal(SentimentScore.neutral))
            }

            it("calls onFailure when remote service fails") {
                remoteServiceMock.returnError = true
                var didCallOnFailure = false

                sut.fetchSentimentScore(forText: "dummy text", onSuccess: { _ in }, onFailure:{
                    didCallOnFailure = true
                })

                expect(didCallOnFailure).to(beTrue())
            }

            it("calls onFailure when cannot parse sentiment score") {
                remoteServiceMock.dataToReturn = "{\"unexpectedObject\": {\"value\": 0}}".data(using: .utf8)
                var didCallOnFailure = false

                sut.fetchSentimentScore(forText: "dummy text", onSuccess: { _ in }, onFailure:{
                    didCallOnFailure = true
                })

                expect(didCallOnFailure).to(beTrue())
            }

            context("when parsing sentiment score value") {
                it("returns 'sad' if score value is between -1.0 and -0.25") {
                    remoteServiceMock.dataToReturn = "{\"documentSentiment\": {\"score\": -0.5}}".data(using: .utf8)
                    var parsedScore: SentimentScore?
                    sut.fetchSentimentScore(forText: "dummy text",
                            onSuccess: { score in
                                parsedScore = score
                            }, onFailure: {}
                    )

                    expect(parsedScore).to(equal(SentimentScore.sad))
                }

                it("returns '.neutral' if score value is between -0.25 and 0.25") {
                    remoteServiceMock.dataToReturn = "{\"documentSentiment\": {\"score\": -0.1}}".data(using: .utf8)
                    var parsedScore: SentimentScore?
                    sut.fetchSentimentScore(forText: "dummy text",
                            onSuccess: { score in
                                parsedScore = score
                            }, onFailure: {}
                    )

                    expect(parsedScore).to(equal(SentimentScore.neutral))
                }

                it("returns '.happy' if score value is between 0.25 and 1.0") {
                    remoteServiceMock.dataToReturn = "{\"documentSentiment\": {\"score\": 0.7}}".data(using: .utf8)
                    var parsedScore: SentimentScore?
                    sut.fetchSentimentScore(forText: "dummy text",
                            onSuccess: { score in
                                parsedScore = score
                            }, onFailure: {}
                    )

                    expect(parsedScore).to(equal(SentimentScore.happy))
                }

                it("returns '.unknown' if score value is minor than -1.0") {
                    remoteServiceMock.dataToReturn = "{\"documentSentiment\": {\"score\": -1.5}}".data(using: .utf8)
                    var parsedScore: SentimentScore?
                    sut.fetchSentimentScore(forText: "dummy text",
                            onSuccess: { score in
                                parsedScore = score
                            }, onFailure: {}
                    )

                    expect(parsedScore).to(equal(SentimentScore.unknown))
                }

                it("returns '.unknown' if score value is greater than 1.0") {
                    remoteServiceMock.dataToReturn = "{\"documentSentiment\": {\"score\": 2.5}}".data(using: .utf8)
                    var parsedScore: SentimentScore?
                    sut.fetchSentimentScore(forText: "dummy text",
                            onSuccess: { score in
                                parsedScore = score
                            }, onFailure: {}
                    )

                    expect(parsedScore).to(equal(SentimentScore.unknown))
                }

            }
        }
    }
}
