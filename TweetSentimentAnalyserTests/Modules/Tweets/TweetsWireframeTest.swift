//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class TweetsWireframeTest: QuickSpec {
    override func spec() {
        describe("TweetsWireframe") {
            var sut: TweetsWireframe!

            beforeEach {
                sut = TweetsWireframe()
            }

            it("creates tweets module with proper username") {
                let module = sut.createModule(with: "username")

                expect(module).toNot(beNil())
                expect(module.username).toNot(beNil())
                expect(module.username).to(equal("username"))
            }
        }
    }
}