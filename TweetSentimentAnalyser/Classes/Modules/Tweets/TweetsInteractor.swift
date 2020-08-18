//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol TweetsInteractorType: class {
    var presenter: TweetsPresenterType? { get set }
    func fetchTweetsFor(username: String)
}

class TweetsInteractor: TweetsInteractorType {
    weak var presenter: TweetsPresenterType?

    func fetchTweetsFor(username: String) {
        print("fetch tweets called")
    }
}