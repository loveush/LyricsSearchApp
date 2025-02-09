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
    func searchLyrics(with songID: Int, completion: @escaping (String) -> Void)
}

class SearchViewPresenter: SearchViewPresenterProtocol {
    weak var view: (any SearchViewProtocol)?
    
    init(view: any SearchViewProtocol) {
        self.view = view
    }
    
    var songs: [FetchedSong] = []
    
    // Search songs related to user input
    func searchSongs(userInput: String?) {
        if !songs.isEmpty {
            songs.removeAll()
            view?.tableView.reloadData()
        }
        
        guard let term = userInput, !term.isEmpty else {
            print("User input name is empty!")
            return
        }
        
        NetworkManager.shared.fetchSongs(for: term) { [weak self] songs in
            guard let self = self else { return }
            DispatchQueue.main.async {
                
                self.songs = songs ?? []
                self.view?.tableView.reloadData()
            }
        }
    }
    
    // Search lyrics for a paticular song
    func searchLyrics(with songID: Int, completion: @escaping (String) -> Void) {
        NetworkManager.shared.fetchLyrics(for: songID) { [weak self] fetchedLyrics in
            guard self != nil else { return }
            
            DispatchQueue.main.async {
                if let lyrics = fetchedLyrics?.lyrics, !lyrics.isEmpty {
                    completion(lyrics)
                } else {
                    completion("No lyrics")
                }
            }
        }
    }
    
}
