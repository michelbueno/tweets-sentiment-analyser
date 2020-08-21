//
// Created by Michel Bueno on 19/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

@testable import TweetSentimentAnalyser

class TweetServiceMock: TweetServiceType {
    var remoteService: RemoteServiceType?

    var didCallFetchTweetsText = false
    var lastUsernameCalled: String?
    var returnError = false
    var listToReturn: [Tweet]?
    var lastStartingFromCalled: String?

    func fetchTweets(forUsername username: String, startingFrom tweetId: String?, onSuccess: @escaping ([Tweet]) -> Void, onFailure: @escaping () -> Void) {
        didCallFetchTweetsText = true
        lastUsernameCalled = username
        lastStartingFromCalled = tweetId
        if returnError {
            onFailure()
        } else {
            onSuccess(listToReturn!)
        }
    }
}