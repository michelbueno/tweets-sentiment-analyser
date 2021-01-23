//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Quick
import Nimble
import UIKit

@testable import TweetSentimentAnalyser

class HomeWireframeTest: QuickSpec {
    override func spec() {
        describe("HomeWireframe") {
            var sut: HomeWireframe!
            var tweetsWireframeMock: TweetsWireframeMock!

            beforeEach {
                tweetsWireframeMock = TweetsWireframeMock()
                sut = HomeWireframe()
                sut.tweetsWireframe = tweetsWireframeMock
            }

            it("creates home module with HomeViewController as root view controller") {
                let module = sut.createModule()

                expect(module).toNot(beNil())
                expect(module.viewControllers.first!).to(beAKindOf(HomeViewController.self))
            }

            it("uses TweetsWireframe to navigate to tweets list screen") {
                sut.navigateToTweetsList(with: "someUsername")

                expect(tweetsWireframeMock.didCallCreateModule).to(beTrue())
                expect(tweetsWireframeMock.lastUsernameCalled).to(equal("someUsername"))
            }
        }

    }
}
