//
//  SearchResultsViewController.swift
//  MusicAlbums
//
//  Created by Markus Faßbender on 15.06.19.
//

import UIKit
import Models
import NetworkService

protocol SearchResultsDelegate: class {
    func didSelectItem(_ item: Artist)
}

class SearchResultsViewController: UITableViewController {
    private struct Constant {
        static let reuseIdentifier = "SearchResultsViewController.reuseIdentifier"
    }
    
    weak var delegate: SearchResultsDelegate?
    
    var results: [Artist] = []
    
    private var imageDownloadTokens: [IndexPath: CancelToken] = [:]
    
    private func cancelAllImageDownloads() {
        imageDownloadTokens.forEach {
            $0.value.cancel()
        }
    }
    
    deinit {
        cancelAllImageDownloads()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorInset = .zero
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
        imageDownloadTokens[indexPath]?.cancel()
        
        let resource = UIImage.image(from: url)
        let token = CancelToken()
        imageDownloadTokens[indexPath] = token
        
        Webservice.shared.load(resource: resource, token: token) {
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
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        imageDownloadTokens[indexPath]?.cancel()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = results[indexPath.row]
        delegate?.didSelectItem(item)
    }
}
