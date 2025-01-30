//
//  Song.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 25.01.2025.
//

import Foundation

struct Song: Codable {
    let artist: String
    let title: String
    let lyrics: String
}

struct SongsResponse: Codable {
    let songs: [Song]
}
