//
//  SearchViewPresenter.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import Foundation

protocol SearchViewPresenterProtocol: AnyObject {
    var songs: [Song] { get set }
    func searchSongs(artist: String?)
    func navigateBack()
    func navigateToLyricsView(songIndex: Int)
}

class SearchViewPresenter: SearchViewPresenterProtocol {
    weak var view: (any SearchViewProtocol)?
    
    init(view: any SearchViewProtocol) {
        self.view = view
    }
    
    var songs: [Song] = []
    
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
    
    func navigateBack() {
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: WindowCase.main])
    }
    
    func navigateToLyricsView(songIndex: Int) {
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [
            String.windowInfo: WindowCase.song,
            "selectedSong": songs[songIndex]
        ])
    }
}
