//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class TweetsViewControllerTest: QuickSpec {
    override func spec() {
        describe("TweetsViewController") {
            var sut: TweetsViewController!
            var presenterMock: TweetsPresenterMock!

            beforeEach {
                presenterMock = TweetsPresenterMock()
                sut = TweetsViewController()
                sut.username = "someUsername"
                sut.presenter = presenterMock
            }

            it("calls presenter on loadView") {
                sut.loadView()

                expect(presenterMock.didCallLoadView).to(beTrue())
            }
        }
    }
}