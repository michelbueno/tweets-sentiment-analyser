//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol TweetsViewControllerType {
    var presenter: TweetsPresenterType? { get set }
    func loadTweets(_ tweetsList: [String])
    func showError()
}

class TweetsViewController: UIViewController, TweetsViewControllerType {
    var presenter: TweetsPresenterType?

    unowned var tweetsView: TweetsView { self.view as! TweetsView }
    unowned var tableView: UITableView { tweetsView.tweetsTableView }

    var username: String?
    var tweets: [String] = []
    var cachedScore: [String: SentimentScore] = [:]

    override func loadView() {
        self.view = TweetsView()
        self.tableView.dataSource = self
        presenter?.loadView(with: username!)
        self.navigationItem.title = "@\(username!)"
    }

    func loadTweets(_ tweetsList: [String]) {
        tweets.append(contentsOf: tweetsList)
        self.tableView.reloadData()
    }

    func showError() {

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
        let text = tweets[indexPath.row]
        let score = cachedScore[text]

        let cell = TweetTableViewCell(style: .subtitle, reuseIdentifier: "tweetCell")
        cell.label.text = text
        if score == nil {
            DispatchQueue.main.async {
                let sentimentService = SentimentScoreService()
                sentimentService.remoteService = RemoteService()
                sentimentService.fetchSentimentScore(for: self.tweets[indexPath.row], onSuccess: {[unowned self] sentimentScore in
                    self.cachedScore[text] = sentimentScore
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }, onFailure: {
                    cell.detailTextLabel?.text = "error"
                })
            }
        } else {
            switch score {
            case .sad:
                cell.imageView?.image = UIImage(named: "sad")
            case .neutral:
                cell.imageView?.image = UIImage(named: "neutral")
            case .happy:
                cell.imageView?.image = UIImage(named: "happy")
            case .none:
                cell.imageView?.image = UIImage(named: "neutral")
            }
        }

        return cell
    }
}