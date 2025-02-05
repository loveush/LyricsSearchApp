//
//  SearchViewPresenter.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import Foundation

protocol SearchViewPresenterProtocol: AnyObject {
    var songs: [FetchedSong] { get set }
    func searchSongs(artist: String?)
}

class SearchViewPresenter: SearchViewPresenterProtocol {
    weak var view: (any SearchViewProtocol)?
    
    init(view: any SearchViewProtocol) {
        self.view = view
    }
    
    var songs: [FetchedSong] = []
    
    func searchSongs(artist: String?) {
        if !songs.isEmpty {
            songs.removeAll()
            view?.tableView.reloadData()
        }
        
        guard let artistName = artist, !artistName.isEmpty else {
            print("Artist name is empty!")
            return
        }
        
        (view as? SearchView)?.activityIndicator.startAnimating()
        
        NetworkManager.shared.fetchSongs(for: artistName) { [weak self] songs in
            guard let self = self else { return }
            DispatchQueue.main.async {
                (self.view as? SearchView)?.activityIndicator.stopAnimating()
                
                self.songs = songs ?? []
                self.view?.tableView.reloadData()
            }
        }
    }
    
}
