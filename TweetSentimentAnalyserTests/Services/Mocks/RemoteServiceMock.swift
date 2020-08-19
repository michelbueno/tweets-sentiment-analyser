//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Alamofire

@testable import TweetSentimentAnalyser

class RemoteServiceMock: RemoteServiceType {
    var didCallGet = false
    var didCallPost = false
    var lastUrlCalled: URL?
    var lastParametersCalled: [String: Any]?
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

    func post(url: URL, parameters: [String: Any], onSuccess: @escaping (Data?) -> (), onFailure: @escaping () -> ()) {
        didCallPost = true
        lastUrlCalled = url
        lastParametersCalled = parameters

        if returnError {
            onFailure()
        } else {
            onSuccess(dataToReturn)
        }
    }
}