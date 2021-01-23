//
// Created by Michel Bueno on 24/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class TweetTableViewCellTest: QuickSpec {
    override func spec() {
        describe("TweetTableViewCell") {
            var sut: TweetsTableViewCell!

            beforeEach {
                sut = TweetsTableViewCell(style: .default, reuseIdentifier: "someID")
            }

            context("on configureImageForSentimentScore") {

                it("hides activity indicator and stops animating") {
                    sut.configureImageForSentimentScore(.happy)

                    expect(sut.activityIndicator.isHidden).to(beTrue())
                    expect(sut.activityIndicator.isAnimating).to(beFalse())
                }

                it("configures correct image for .happy sentiment score") {
                    sut.configureImageForSentimentScore(.happy)

                    expect(sut.imageView?.image).toNot(beNil())
                    expect(sut.imageView?.image).to(equal(UIImage(named: "happy")))
                }

                it("configures correct image for .sad sentiment score") {
                    sut.configureImageForSentimentScore(.sad)

                    expect(sut.imageView?.image).toNot(beNil())
                    expect(sut.imageView?.image).to(equal(UIImage(named: "sad")))
                }

                it("configures correct image for .neutral sentiment score") {
                    sut.configureImageForSentimentScore(.neutral)

                    expect(sut.imageView?.image).toNot(beNil())
                    expect(sut.imageView?.image).to(equal(UIImage(named: "neutral")))
                }

                it("configures correct image for .neutral sentiment score") {
                    sut.configureImageForSentimentScore(.unknown)

                    expect(sut.imageView?.image).toNot(beNil())
                    expect(sut.imageView?.image).to(equal(UIImage(named: "unknown")))
                }
            }
        }

    }
}
