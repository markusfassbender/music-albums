//
//  SearchViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit
import Models
import NetworkService

class SearchViewController: UITableViewController {
    private var searchCancelToken: CancelToken?
    
    deinit {
        searchCancelToken?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        title = NSLocalizedString("title_search", comment: "")
        
        tableView.separatorInset = .zero
        
        let resultsViewcontroller = SearchResultsViewController()
        resultsViewcontroller.delegate = self
        resultsViewcontroller.tableView.separatorInset = tableView.separatorInset
        
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
        guard
            let viewController = searchController.searchResultsController as? SearchResultsViewController,
            let input = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces),
            !input.isEmpty
        else {
            return
        }
        
        updateSearchResults(on: viewController, for: input)
    }
    
    private func updateSearchResults(on viewController: SearchResultsViewController, for input: String) {
        searchCancelToken?.cancel()
        
        let resource = Artist.all(for: input)
        let cancelToken = CancelToken()
        searchCancelToken = cancelToken
        
        Webservice.shared.load(resource: resource, token: cancelToken) { result in
            switch result {
            case .success(let artists):
                viewController.results = artists
                
                DispatchQueue.main.async {
                    viewController.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                break;
            }
        }
    }
}

extension SearchViewController: SearchResultsDelegate {
    func didSelectItem(_ item: Artist) {
        let artistViewController = ArtistViewController(artist: item)
        
        navigationController?.pushViewController(artistViewController, animated: true)
    }
}
