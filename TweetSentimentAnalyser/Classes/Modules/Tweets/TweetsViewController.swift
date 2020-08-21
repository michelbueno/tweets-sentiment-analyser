//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol TweetsViewControllerType {
    var presenter: TweetsPresenterType? { get set }
    func loadTweets(_ tweetsList: [Tweet])
    func showError()
    func updateTweet(_: Tweet)
}

class TweetsViewController: UIViewController, TweetsViewControllerType {
    var presenter: TweetsPresenterType?

    unowned var tweetsView: TweetsView { self.view as! TweetsView }
    unowned var tableView: UITableView { tweetsView.tweetsTableView }

    var username: String?
    var tweets: [Tweet] = []

    override func loadView() {
        self.view = TweetsView()
        self.tableView.dataSource = self
        presenter?.loadView(with: username!)
        self.navigationItem.title = "@\(username!)"
    }

    func loadTweets(_ tweetsList: [Tweet]) {
        tweets.append(contentsOf: tweetsList)
        self.tableView.reloadData()
    }

    func showError() {

    }

    func updateTweet(_ tweet: Tweet) {
        let index = tweets.firstIndex { $0 === tweet }
        tweets[index!] = tweet

        self.tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: .fade)
    }
}

extension TweetsViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweet = tweets[indexPath.row]
        let cell = TweetsTableViewCell(style: .subtitle, reuseIdentifier: "tweetCell")
        cell.label.text = tweet.text

        if let sentimentScore = tweet.sentimentScore {
            cell.configureImageForSentimentScore(sentimentScore)
        } else {
            presenter?.viewWillDisplayCellForTweet(tweet)
        }

        return cell
    }
}
