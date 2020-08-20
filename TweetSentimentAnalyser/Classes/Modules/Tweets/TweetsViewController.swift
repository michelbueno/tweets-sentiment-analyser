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

    unowned var tweetsView: TweetsView { return self.view as! TweetsView }
    unowned var tableView: UITableView { return tweetsView.tweetsTableView }

    var username: String?
    var tweets: [String] = []

    override func loadView() {
        self.view = TweetsView()
        self.tableView.dataSource = self
        presenter?.loadView(with: username!)
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "tweetCell")
        cell.textLabel?.text = tweets[indexPath.row]
        cell.backgroundColor = .darkGray
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 0

        return cell
    }
}