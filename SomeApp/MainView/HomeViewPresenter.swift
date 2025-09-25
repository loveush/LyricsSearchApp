import Foundation

protocol HomeViewPresenterProtocol: AnyObject {
    var greeting: String { get }
    var songs: [Song] { get }
    
    func fetchUserSongs()
}

class HomeViewPresenter: HomeViewPresenterProtocol {
    weak var view: (any HomeViewProtocol)?
    
    init(view: any HomeViewProtocol) {
        self.view = view
    }
    
    var songs: [Song] = []
    
    private let userName = String(UserDefaults.standard.string(forKey: "name") ?? "User")
    lazy var greeting = "Hello, \(userName)!"
    
    func fetchUserSongs() {
        DispatchQueue.main.async {
            self.songs = StorageManager.shared.fetchSongs()
            self.view?.tableView.reloadData()
        }
    }
}
