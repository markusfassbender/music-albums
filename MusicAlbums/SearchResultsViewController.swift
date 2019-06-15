//
//  SearchResultsViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

protocol SearchResultsDelegate: class {
    func didSelectItem(_ item: Artist)
}

class SearchResultsViewController: UITableViewController {
    private struct Constant {
        static let reuseIdentifier = "SearchResultsViewController.reuseIdentifier"
    }
    
    var results: [Artist] = []
    weak var delegate: SearchResultsDelegate?
    
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artist = results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = artist.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = results[indexPath.row]
        delegate?.didSelectItem(item)
    }
}
