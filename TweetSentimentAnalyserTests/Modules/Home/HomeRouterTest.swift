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
            let sut = HomeRouter()

            it("creates home module with HomeViewController as root view controller") {
                let module = sut.createModule()

                expect(module).toNot(beNil())
                expect(module.viewControllers.first!).to(beAKindOf(HomeViewController.self))
            }
        }

    }
}

