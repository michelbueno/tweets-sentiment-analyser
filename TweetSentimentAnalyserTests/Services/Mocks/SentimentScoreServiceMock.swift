//
// Created by Michel Bueno on 21/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

class SentimentScoreServiceMock: SentimentScoreServiceType {
    var remoteService: RemoteServiceType?
    var didCallFetchSentimentScore = false
    var returnError = false
    var sentimentScoreToReturn: SentimentScore?
    var lastTextCalled: String?

    func fetchSentimentScore(forText text: String, onSuccess: @escaping (SentimentScore) -> Void, onFailure: @escaping () -> Void) {
        didCallFetchSentimentScore = true
        lastTextCalled = text
        if returnError {
            onFailure()
        } else {
            onSuccess(sentimentScoreToReturn!)
        }
    }

}
