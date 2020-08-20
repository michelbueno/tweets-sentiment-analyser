//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Quick
import Nimble
import UIKit

@testable import TweetSentimentAnalyser

class HomeRouterTest: QuickSpec {
    override func spec() {
        describe("HomeRouter") {
            var sut: HomeRouter!
            var tweetsRouterMock: TweetsRouterMock!

            beforeEach {
                tweetsRouterMock = TweetsRouterMock()
                sut = HomeRouter()
                sut.tweetsRouter = tweetsRouterMock
            }

            it("creates home module with HomeViewController as root view controller") {
                let module = sut.createModule()

                expect(module).toNot(beNil())
                expect(module.viewControllers.first!).to(beAKindOf(HomeViewController.self))
            }

            it("uses tweets router to navigate to tweets list screen") {
                sut.navigateToTweetsList(with: "someUsername")

                expect(tweetsRouterMock.didCallCreateModule).to(beTrue())
                expect(tweetsRouterMock.lastUsernameCalled).to(equal("someUsername"))
            }
        }

    }
}

