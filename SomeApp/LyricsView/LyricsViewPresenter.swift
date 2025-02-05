//
//  LyricsViewPresenter.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import Foundation

protocol LyricsViewPresenterProtocol: AnyObject {
    var song: FetchedSong { get }
    var artistLabel: String { get }
}

class LyricsViewPresenter: LyricsViewPresenterProtocol {
    let song: FetchedSong
    lazy var artistLabel = "by \(song.artist)"
    
    weak var view: (any LyricsViewProtocol)?
    
    init(view: any LyricsViewProtocol, song: FetchedSong) {
        self.view = view
        self.song = song
    }
    
}
