//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import TweetSentimentAnalyser

class RemoteServiceTest: QuickSpec {
    override func spec() {
        describe("RemoteService") {
            var sut: RemoteService!

            beforeEach {
                sut = RemoteService()
            }

            context("GET") {
                it("calls onFailure when request fails") {
                    stub(condition: isAbsoluteURLString("http://my-service.com/failure")) { _ in
                        let genericError = NSError(domain: "Generic error", code: Int(1234), userInfo: nil)
                        return HTTPStubsResponse(error: genericError)
                    }

                    var didCallOnFailure = false
                    let expectation = self.expectation(description: "async call")
                    sut.get(url: URL(string: "http://my-service.com/failure")!, headers: [], onSuccess: { _ in }, onFailure: {
                        didCallOnFailure = true
                        expectation.fulfill()
                    })

                    self.waitForExpectations(timeout: 1, handler: { error in
                        expect(error).to(beNil())
                        expect(didCallOnFailure).to(beTrue())
                    })
                }

                it("calls onSuccess when request succeeds") {
                    stub(condition: isAbsoluteURLString("http://my-service.com/success")) { _ in
                        let obj = ["key1": "value1"]
                        return HTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
                    }
                    var didCallOnSuccess = false
                    let expectation = self.expectation(description: "async call")
                    sut.get(url: URL(string: "http://my-service.com/success")!, headers: ["dummyHeader": "dummyValue"], onSuccess: { _ in
                        didCallOnSuccess = true
                        expectation.fulfill()
                    }, onFailure: {})

                    self.waitForExpectations(timeout: 1, handler: { error in
                        expect(error).to(beNil())
                        expect(didCallOnSuccess).to(beTrue())
                    })
                }
            }

            context("POST") {
                it("calls onFailure when request fails") {
                    stub(condition: isAbsoluteURLString("http://my-service.com/failure")) { _ in
                        let genericError = NSError(domain: "Generic error", code: Int(1234), userInfo: nil)
                        return HTTPStubsResponse(error: genericError)
                    }

                    let body = ["someField": "someValue"]
                    var didCallOnFailure = false
                    let expectation = self.expectation(description: "async call")

                    sut.post(url: URL(string: "http://my-service.com/failure")!, parameters: body, onSuccess: { _ in }, onFailure: {
                        didCallOnFailure = true
                        expectation.fulfill()
                    })

                    self.waitForExpectations(timeout: 1, handler: { error in
                        expect(error).to(beNil())
                        expect(didCallOnFailure).to(beTrue())
                    })
                }

                it("calls onSuccess when request succeeds") {
                    stub(condition: isAbsoluteURLString("http://my-service.com/success")) { _ in
                        let obj = ["key1": "value1"]
                        return HTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
                    }
                    var didCallOnSuccess = false
                    let expectation = self.expectation(description: "async call")
                    let body = ["someField": "someValue"]
                    sut.post(url: URL(string: "http://my-service.com/success")!, parameters: body, onSuccess: { _ in
                        didCallOnSuccess = true
                        expectation.fulfill()
                    }, onFailure: {})

                    self.waitForExpectations(timeout: 1, handler: { error in
                        expect(error).to(beNil())
                        expect(didCallOnSuccess).to(beTrue())
                    })
                }
            }
        }
    }

}
