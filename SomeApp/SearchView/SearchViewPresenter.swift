//
//  SearchViewPresenter.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import Foundation

protocol SearchViewPresenterProtocol: AnyObject {
    var songs: [FetchedSong] { get set }
    func searchSongs(userInput: String?)
}

class SearchViewPresenter: SearchViewPresenterProtocol {
    weak var view: (any SearchViewProtocol)?
    var lyrics: String?
    
    init(view: any SearchViewProtocol) {
        self.view = view
    }
    
    var songs: [FetchedSong] = []
    
    func searchSongs(userInput: String?) {
        if !songs.isEmpty {
            songs.removeAll()
            view?.tableView.reloadData()
        }
        
        guard let term = userInput, !term.isEmpty else {
            print("User input name is empty!")
            return
        }
        
//        (view as? SearchView)?.activityIndicator.startAnimating()
        
        NetworkManager.shared.fetchSongs(for: term) { [weak self] songs in
            guard let self = self else { return }
            DispatchQueue.main.async {
//                (self.view as? SearchView)?.activityIndicator.stopAnimating()
                
                self.songs = songs ?? []
                self.view?.tableView.reloadData()
            }
        }
    }
    
}
