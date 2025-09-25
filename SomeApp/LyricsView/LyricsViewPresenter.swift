import Foundation

protocol LyricsViewPresenterProtocol: AnyObject {
    var title: String { get }
    var artistLabel: String { get }
    var lyrics: String { get }
    var isAdded: Bool { get }
    
    func deleteSong()
    func addSong()
}

class LyricsViewPresenter: LyricsViewPresenterProtocol {
    private let songID: Int64
    let title: String
    let lyrics: String
    private let artist: String
    
    weak var view: (any LyricsViewProtocol)?
    
    init(view: any LyricsViewProtocol, id: Int64, title: String, artist: String, lyrics: String) {
        self.view = view
        self.songID = id
        self.title = title
        self.artist = artist
        self.lyrics = lyrics
    }
    
    lazy var artistLabel = "by \(artist)"


    var isAdded: Bool {
        return storage.fetchSong(with: songID) != nil
    }
    
    // Storage managing
    let storage = StorageManager.shared
    
    func deleteSong() {
        if isAdded {
            storage.deleteSong(with: songID)
            printAllSongs()
        }
    }
    func addSong() {
        if !isAdded {
            storage.addSong(id: songID, title: title, artist: artist, lyrics: lyrics)
            printAllSongs()
        }
    }
    
    // Debugging
    func printAllSongs() {
        let songs = StorageManager.shared.fetchSongs()
        if songs.isEmpty {
            print("Database is empty")
        } else {
            print("Songs in Database:")
            for song in songs {
                print("ID: \(song.id), Title: \(song.title ?? "Unknown"), Artist: \(song.artist ?? "Unknown")")
            }
        }
    }
        
}
