import Foundation

struct FetchedSong: Decodable {
    let title: String
    let artist: String
    let id: Int64
}

struct SongsResponse: Decodable {
    let songs: [FetchedSong]
}

struct FetchedLyrics: Decodable {
    let lyrics: String
}
