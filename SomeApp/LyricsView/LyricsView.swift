//
//  LyricsView.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 25.01.2025.
//

import UIKit

protocol LyricsViewProtocol: BaseViewProtocol {
    var lyricsTextView: UITextView { get set }
    var activityIndicator: UIActivityIndicatorView { get set }
}

class LyricsView: UIViewController, LyricsViewProtocol {
    //MARK: - Presenter
    typealias PresenterType = LyricsViewPresenterProtocol
    var presenter: PresenterType?
    
    //MARK: - Override functions
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.searchLyrics()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setUpView()
    }
    
    //MARK: - View components
    private let backButton = CustomBackButton()
    private let titleLabel = CustomTitleLabel(label: "Lyrics")
    
    private lazy var songTitleLabel: UILabel = {
        let label = UILabel()
        label.text = presenter?.title
        label.textColor = .geniusYellow
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    private lazy var songArtistLabel: UILabel = {
        let label = UILabel()
        label.text = presenter?.artistLabel
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var lyricsTextView: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.layoutIfNeeded()
        textView.textColor = .white
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.isHidden = true
        return textView
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
}

//MARK: - Setting Views
private extension LyricsView {
    func setUpView() {
        addSubViews()
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        setUpLayout()
    }
}

//MARK: - Subviews
private extension LyricsView {
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(songTitleLabel)
        view.addSubview(songArtistLabel)
        view.addSubview(activityIndicator)
        view.addSubview(lyricsTextView)
    }
}

//MARK: - Layout
private extension LyricsView {
    func setUpLayout() {
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        songArtistLabel.translatesAutoresizingMaskIntoConstraints = false
        lyricsTextView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            songTitleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            songTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            songArtistLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 10),
            songArtistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songArtistLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lyricsTextView.topAnchor.constraint(equalTo: songArtistLabel.bottomAnchor, constant: 20),
            lyricsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lyricsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lyricsTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

private extension LyricsView {
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
