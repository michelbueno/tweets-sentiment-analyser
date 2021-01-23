//
//  HomeViewTests.swift
//  TweetSentimentAnalyserTests
//
//  Created by Michel Bueno on 23/01/21.
//  Copyright © 2021 Michel Bueno. All rights reserved.
//

import Foundation
import XCTest
import FBSnapshotTestCase

@testable import TweetSentimentAnalyser

class HomeViewTests: FBSnapshotTestCase {
    func testHasValidSnapShot() {
        let sut = HomeView(frame: UIApplication.shared.windows.first { $0.isKeyWindow }!.safeAreaLayoutGuide.layoutFrame)
        
        FBSnapshotVerifyView(sut)
    }
}
