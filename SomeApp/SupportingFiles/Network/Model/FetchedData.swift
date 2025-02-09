//
//  FetchedData.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 25.01.2025.
//

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
