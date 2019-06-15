//
//  SearchViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit

class SearchViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        title = NSLocalizedString("title_search", comment: "")
        
        let resultsViewcontroller = SearchResultsViewController()
        resultsViewcontroller.delegate = self
        
        let searchController = UISearchController(searchResultsController: resultsViewcontroller)
        searchController.searchResultsUpdater = self
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        
        definesPresentationContext = true
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsViewController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        
        resultsViewController.results = ["John Lennon"]
        resultsViewController.tableView.reloadData()
    }
}

extension SearchViewController: SearchResultsDelegate {
    func didSelectItem(_ item: String) {
        let artist = item
        let artistViewController = ArtistViewController(artist: artist)
        
        navigationController?.pushViewController(artistViewController, animated: true)
    }
}
