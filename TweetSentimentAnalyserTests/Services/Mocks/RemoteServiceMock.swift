//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Alamofire

@testable import TweetSentimentAnalyser

class RemoteServiceMock: RemoteServiceType {
    var didCallGet = false
    var lastUrlCalled: URL?
    var lastHeadersCalled: HTTPHeaders?
    var returnError = false
    var dataToReturn: Data?

    func get(url: URL, headers: HTTPHeaders, onSuccess: @escaping (Data?) -> Void, onFailure: @escaping () -> Void) {
        didCallGet = true
        lastUrlCalled = url
        lastHeadersCalled = headers

        if returnError {
            onFailure()
        } else {
            onSuccess(dataToReturn)
        }
    }


}