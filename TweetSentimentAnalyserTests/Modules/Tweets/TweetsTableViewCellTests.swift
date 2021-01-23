//
//  TweetsViewTests.swift
//  TweetSentimentAnalyserTests
//
//  Created by Michel Bueno on 23/01/21.
//  Copyright © 2021 Michel Bueno. All rights reserved.
//

import Foundation
import XCTest
import FBSnapshotTestCase

@testable import TweetSentimentAnalyser

class TweetsTableViewCellTests: FBSnapshotTestCase {

    var sut: TweetsTableViewCell!

    override func setUp() {
        super.setUp()
        self.sut = TweetsTableViewCell(style: .default, reuseIdentifier: "")
        sut.frame = CGRect(x: 0, y: 0, width: 390, height: 81)
        sut.label.text = "Dummy text for cell label"
    }

    func testHasValidSnapshotForUnknownSentment() {
        sut.configureImageForSentimentScore(.unknown)

        FBSnapshotVerifyView(sut)
    }

    func testHasValidSnapshotForHappySentment() {
        sut.configureImageForSentimentScore(.happy)

        FBSnapshotVerifyView(sut)
    }

    func testHasValidSnapshotForNeutralSentment() {
        sut.configureImageForSentimentScore(.neutral)

        FBSnapshotVerifyView(sut)
    }

    func testHasValidSnapshotForSadSentment() {
        sut.configureImageForSentimentScore(.sad)

        FBSnapshotVerifyView(sut)
    }
}
