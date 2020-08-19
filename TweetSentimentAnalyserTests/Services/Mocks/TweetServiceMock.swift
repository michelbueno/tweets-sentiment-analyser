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
    var listToReturn: [String]?

    func fetchTweetsTextFor(username: String, onSuccess: @escaping ([String]) -> Void, onFailure: @escaping () -> Void) {
        didCallFetchTweetsText = true
        lastUsernameCalled = username
        if returnError {
            onFailure()
        } else {
            onSuccess(listToReturn!)
        }
    }


}