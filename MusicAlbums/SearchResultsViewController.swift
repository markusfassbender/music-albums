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
        super.viewDidLoad()
        tableView.register(ArtistCell.self, forCellReuseIdentifier: Constant.reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseIdentifier, for: indexPath)
        let artist = results[indexPath.row]
        
        configureCell(cell, at: indexPath, with: artist)
        
        return cell
    }
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist) {
        guard let cell = cell as? ArtistCell else {
            return
        }
        
        let image = artist.image
        let name = artist.name
        let viewModel = ArtistCell.ViewModel(image: image, artistName: name)
        cell.configure(with: viewModel)
        
        if image == nil, let imageURL = artist.imageURL {
            downloadImage(from: imageURL, for: indexPath)
        }
    }
    
    private func downloadImage(from url: URL, for indexPath: IndexPath) {
        let resource = UIImage.image(from: url)
        Webservice.shared.load(resource: resource, token: nil) {
            switch $0 {
            case .success(let image):
                let artist = self.results[indexPath.row].new(with: image)
                self.results[indexPath.row] = artist
                
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = results[indexPath.row]
        delegate?.didSelectItem(item)
    }
}
