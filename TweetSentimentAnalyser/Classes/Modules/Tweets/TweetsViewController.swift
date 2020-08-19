//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

class TweetsViewController: UIViewController {
    unowned var tweetsView: TweetsView { return self.view as! TweetsView }
    unowned var tableView: UITableView { return tweetsView.tweetsTableView }
    var tweets: [Tweet] = []

    override func loadView() {
        self.view = TweetsView()
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        cell.textLabel?.text = tweets[indexPath.row].text
        cell.detailTextLabel?.text = "\(tweets[indexPath.row].sentimentScore)"
        cell.backgroundColor = .darkGray
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white

        return cell

    }
}