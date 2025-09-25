import UIKit

protocol SearchViewProtocol: BaseViewProtocol {
    var tableView: UITableView { get }
}

class SearchView: UIViewController, SearchViewProtocol {
    //MARK: - Presenter
    typealias PresenterType = SearchViewPresenterProtocol
    var presenter: PresenterType?

    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setUpView()
    }
    
    // MARK: - View components
    private let titleLabel = CustomTitleLabel(label: "Search lyrics")
    private let searchField = CustomTextField(placeholder: "Enter artist name...")
    private let backButton = CustomBackButton()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .geniusYellow
        button.tintColor = .black
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
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
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
}

//MARK: - Setting Views
private extension SearchView {
    func setUpView() {
        addSubViews()
        
        tableView.dataSource = self
        tableView.delegate = self
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        
        setUpLayout()
    }
}

//MARK: - Subviews
private extension SearchView {
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(searchField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
}

//MARK: - Layout
private extension SearchView {
    func setUpLayout() {
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            searchButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.widthAnchor.constraint(equalToConstant: 70),
            
            searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - TableView
extension SearchView: UITableViewDataSource{
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

extension SearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chosenSong = presenter?.songs[indexPath.row] else { return }

        activityIndicator.startAnimating()

        presenter?.searchLyrics(with: Int(chosenSong.id)) { [weak self] lyrics in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.activityIndicator.stopAnimating() 

                let lyricsViewController = Builder.createLyricsView(id: chosenSong.id,
                                                                    titile: chosenSong.title,
                                                                    artist: chosenSong.artist,
                                                                    lyrics: lyrics)
                self.navigationController?.pushViewController(lyricsViewController, animated: true)
            }
        }
    }
}

//MARK: - Button actions
private extension SearchView {
    @objc func didTapSearchButton() {
        presenter?.searchSongs(userInput: searchField.text)
    }
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
