import UIKit

protocol HomeViewProtocol: BaseViewProtocol {
    var tableView: UITableView { get }
}

class HomeView: UIViewController, HomeViewProtocol {
    //MARK: - Presenter
    typealias PresenterType = HomeViewPresenterProtocol
    var presenter: PresenterType?
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setUpView()
    }
    
    //MARK: - View Components
    private let button = CustomButton(title: "Search lyrics")
    private lazy var titleLabel = CustomTitleLabel(label: presenter?.greeting ?? "Hello!")
    
    private lazy var favoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorite songs"
        label.textColor = .geniusYellow
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        return label
    }()
    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .black
        table.separatorColor = .white
        table.register(CustomCell.self, forCellReuseIdentifier: "songCell")
        table.isUserInteractionEnabled = true
        table.rowHeight = 65
        return table
    }()
}

//MARK: - Setting Views
private extension HomeView {
    func setUpView() {
        navigationController?.navigationBar.isHidden = true
        
        addSubViews()
        setUpLayout()
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        tableView.dataSource = self
        tableView.delegate = self

        presenter?.fetchUserSongs()
    }
}

//MARK: - Subviews
private extension HomeView {
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(button)
        view.addSubview(favoritesLabel)
        view.addSubview(tableView)
    }
}

//MARK: - Layout
private extension HomeView {
    func setUpLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        favoritesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            favoritesLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 25),
            favoritesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            favoritesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: favoritesLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - TableView
extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.songs.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! CustomCell
        cell.title.text = presenter?.songs[indexPath.row].title
        cell.artist.text = presenter?.songs[indexPath.row].artist
        return cell
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let chosenSong = presenter?.songs[indexPath.row] else { return }
        
        let lyricsViewController = Builder.createLyricsView(id: chosenSong.id,
                                                            titile: chosenSong.title,
                                                            artist: chosenSong.artist,
                                                            lyrics: chosenSong.lyrics)
        
        self.navigationController?.pushViewController(lyricsViewController, animated: true)
    }
}

//MARK: - Button action
private extension HomeView {
    @objc func didTapButton() {
        let vc = Builder.createSearchView()
        navigationController?.pushViewController(vc, animated: true)
    }
}
