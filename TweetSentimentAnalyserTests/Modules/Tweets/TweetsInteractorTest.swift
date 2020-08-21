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
        var sentimentScoreServiceMock: SentimentScoreServiceMock!
        var presenterMock: TweetsPresenterMock!

        describe("TweetInteractor") {
            beforeEach {
                tweetServiceMock = TweetServiceMock()
                tweetServiceMock.listToReturn = [Tweet()]
                sentimentScoreServiceMock = SentimentScoreServiceMock()
                sentimentScoreServiceMock.sentimentScoreToReturn = .neutral

                presenterMock = TweetsPresenterMock()

                sut = TweetsInteractor()
                sut.tweetService = tweetServiceMock
                sut.sentimentScoreService = sentimentScoreServiceMock
                sut.presenter = presenterMock
            }

            context("when fetching tweets") {
                it("uses TweetService to fetch tweets with correct params") {
                    sut.fetchTweets(forUsername: "username", startingFrom: "123456")

                    expect(tweetServiceMock.didCallFetchTweetsText).to(beTrue())
                    expect(tweetServiceMock.lastUsernameCalled).to(equal("username"))
                    expect(tweetServiceMock.lastStartingFromCalled).to(equal("123456"))
                }

                it("calls presenter to show error when TweetService fails") {
                    tweetServiceMock.returnError = true

                    sut.fetchTweets(forUsername: "username", startingFrom: nil)

                    expect(presenterMock.didCallFailedToFetchTweets).to(beTrue())
                }

                it("calls presenter with a list of tweets when request succeeds") {
                    tweetServiceMock.listToReturn = [Tweet()]

                    sut.fetchTweets(forUsername: "username", startingFrom: nil)

                    expect(presenterMock.didCallShowTweets).to(beTrue())
                }
            }

            context("when fetching sentiment score") {
                var tweet: Tweet!

                beforeEach {
                    tweet = Tweet()
                    tweet.text = "a tweet"
                }

                it("calls SentimentScoreService to fetch sentiment score") {
                    sut.getSentimentScore(forTweet: tweet)

                    expect(sentimentScoreServiceMock.didCallFetchSentimentScore).to(beTrue())
                    expect(sentimentScoreServiceMock.lastTextCalled).to(equal("a tweet"))
                }

                it("calls presenter when SentimentScoreService fails") {
                    sentimentScoreServiceMock.returnError = true

                    sut.getSentimentScore(forTweet: tweet)

                    expect(presenterMock.didCallFailedToGetSentimentScoreForTweet).to(beTrue())
                    expect(presenterMock.lastTweeCalledByFailedToGetSentimentScore?.text).to(equal("a tweet"))
                }

                it("calls presenter to update the Tweet") {
                    sut.getSentimentScore(forTweet: tweet)

                    expect(presenterMock.didCallUpdateTweet).to(beTrue())
                    expect(presenterMock.lastTweetCalledByUpdateTweet?.text).to(equal("a tweet"))
                }
            }
        }

    }
}
