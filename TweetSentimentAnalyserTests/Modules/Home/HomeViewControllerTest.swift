//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class HomeViewControllerTest: QuickSpec {
    override func spec() {
        describe("HomeViewController") {
            var sut = HomeViewController()
            var presenterMock = HomePresenterMock()
            sut.presenter = presenterMock

            it("calls presenter on analyse button pressed with correct param") {
                sut.usernameTextField.text = "someUsername" 
                sut.analyseButton.sendActions(for: .touchUpInside)

                expect(presenterMock.didCallOnAnaliseButtonPressed).to(beTrue())
                expect(presenterMock.lastUsernameCalled).to(equal("someUsername"))
            }
        }
    }
}