import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "http://127.0.0.1:7000"
    
    // Generic function to make API requests
    private func performRequest<T: Decodable>(
        endpoint: String,
        body: [String: Any],
        completion: @escaping (T?) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(decodedResponse)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    // Fetching songs list by user input
    func fetchSongs(for term: String, completion: @escaping ([FetchedSong]?) -> Void) {
        performRequest(endpoint: "/search", body: ["term": term]) { (response: SongsResponse?) in
            completion(response?.songs)
        }
    }
    
    // Fetching lyrics for the particular song by id
    func fetchLyrics(for songID: Int, completion: @escaping (FetchedLyrics?) -> Void) {
        performRequest(endpoint: "/lyrics", body: ["song_id": songID], completion: completion)
    }
}
