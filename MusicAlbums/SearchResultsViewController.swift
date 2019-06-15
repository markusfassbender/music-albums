//
//  SearchResultsViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

class SearchResultsViewController: UITableViewController {
    private struct Constant {
        static let reuseIdentifier = "SearchResultsViewController.reuseIdentifier"
    }
    
    var results: [String] = []
    
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = results[indexPath.row]
        
        return cell
    }
}
