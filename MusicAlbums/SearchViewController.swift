//
//  SearchViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit
import Models
import NetworkService

class SearchViewController: UIViewController {
    private var searchCancelToken: CancelToken?
    
    deinit {
        searchCancelToken?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = Stylesheet.Color.viewBackground
        title = NSLocalizedString("title_search", comment: "")
        
        let resultsViewcontroller = SearchResultsViewController()
        resultsViewcontroller.delegate = self
        
        let searchController = UISearchController(searchResultsController: resultsViewcontroller)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "")
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
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
        let albumSelectionViewController = AlbumSelectionViewController(artist: item)
        navigationController?.pushViewController(albumSelectionViewController, animated: true)
    }
}
