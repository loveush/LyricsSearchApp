//
//  NetworkManager.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 25.01.2025.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "http://localhost:7000"
    
    func fetchSongs(for artist: String, completion: @escaping ([FetchedSong]?) -> Void) {
        
        guard let url = URL(string: "http://127.0.0.1:7000/search") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["artist": artist, "nb_songs": 2]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
//            print("Raw JSON: \(String(data: data, encoding: .utf8) ?? "Invalid JSON")")
            do {
                let songsResponse = try JSONDecoder().decode(SongsResponse.self, from: data)
                completion(songsResponse.songs)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
