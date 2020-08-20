//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

enum SentimentScore {
    case happy, neutral, sad
}

class Tweet {
    var text: String?
    var score: SentimentScore?
}