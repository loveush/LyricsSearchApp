//
//  LyricsViewPresenter.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import Foundation

protocol LyricsViewPresenterProtocol: AnyObject {
    var title: String { get }
    var artistLabel: String { get }
    var lyrics: String? { get }
    
    func searchLyrics()
}

class LyricsViewPresenter: LyricsViewPresenterProtocol {
    let song: FetchedSong
    var lyrics: String?
    
    weak var view: (any LyricsViewProtocol)?
    
    init(view: any LyricsViewProtocol, song: FetchedSong) {
        self.view = view
        self.song = song
    }
    
    lazy var songID = song.id
    lazy var artistLabel = "by \(song.artist)"
    lazy var title = song.title
    
    func searchLyrics() {
        view?.activityIndicator.startAnimating()
        
        NetworkManager.shared.fetchLyrics(for: songID) { [weak self] fetchedLyrics in
            guard let self = self else { return }
//            print(songID)
            
            DispatchQueue.main.async {
                self.view?.activityIndicator.stopAnimating()
                
                if let lyrics = fetchedLyrics?.lyrics, !lyrics.isEmpty {
                    self.view?.lyricsTextView.text = lyrics
                    self.view?.lyricsTextView.isHidden = false
                } else {
                    self.view?.lyricsTextView.isHidden = true
                }
            }
        }
    }
    
}
