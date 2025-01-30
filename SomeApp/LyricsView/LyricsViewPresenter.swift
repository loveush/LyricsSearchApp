//
//  LyricsViewPresenter.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import Foundation

protocol LyricsViewPresenterProtocol: AnyObject {
    var song: Song { get }
    func navigateBack()
    var artistLabel: String { get }
}

class LyricsViewPresenter: LyricsViewPresenterProtocol {
    weak var view: (any LyricsViewProtocol)?
    
    let song: Song
    
    init(view: any LyricsViewProtocol, song: Song) {
        self.view = view
        self.song = song
    }
    
    lazy var artistLabel = "by \(song.artist)"
    
    func navigateBack() {
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: WindowCase.search])
    }
    
}
