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
    func setUnknownScoreForTweet(_: Tweet)
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
        if tweets.count == 0 {
            tweets.append(contentsOf: tweetsList)
            self.tableView.reloadData()
        } else {
            tweets.append(contentsOf: tweetsList)
            var newIndexPaths = [IndexPath]()
            for rowPosition in 0..<tweetsList.count {
                let newIndexPath = IndexPath(row: tweetsList.count + rowPosition, section: 0)
                newIndexPaths.append(newIndexPath)
            }
            self.tableView.insertRows(at: newIndexPaths, with: .automatic)
        }
    }

    func showError() {

    }

    func updateTweet(_ tweet: Tweet) {
        let index = tweets.firstIndex { $0 === tweet }
        tweets[index!] = tweet
        let indexPath = IndexPath(row: index!, section: 0)

        if (tableView.indexPathsForVisibleRows?.contains(indexPath))! {
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }

    func setUnknownScoreForTweet(_ tweet: Tweet) {
        let index = tweets.firstIndex { $0 === tweet }
        let indexPath = IndexPath(row: index!, section: 0)

        if (tableView.indexPathsForVisibleRows?.contains(indexPath))! {
            let cell = tableView.cellForRow(at: indexPath) as! TweetsTableViewCell
            cell.configureUnknownSentimentScore()
        }
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

        if indexPath.row == tweets.count-1 {
            presenter?.fetchMoreTweets(forUsername: username!, startingFrom: tweets.last!.id!)
        }

        return cell
    }
}
