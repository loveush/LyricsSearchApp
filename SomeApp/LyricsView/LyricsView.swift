//
//  LyricsView.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 25.01.2025.
//

import UIKit

protocol LyricsViewProtocol: BaseViewProtocol {
    
}

class LyricsView: UIViewController, LyricsViewProtocol {
    //MARK: - Presenter
    typealias PresenterType = LyricsViewPresenterProtocol
    var presenter: PresenterType?
    
    //MARK: - Private properties
    private let backButton = CustomBackButton()
    private let titleLabel = CustomTitleLabel(label: "Lyrics")
    
    private lazy var songTitleLabel: UILabel = {
        let label = UILabel()
        label.text = presenter?.song.title
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
    private lazy var lyricsTextView: UITextView = {
        let textView = UITextView()
        textView.text = presenter?.song.lyrics
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.layoutIfNeeded()
        textView.textColor = .white
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        return textView
    }()
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setUpView()
    }
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
        view.addSubview(lyricsTextView)
    }
}

//MARK: - Layout
private extension LyricsView {
    func setUpLayout() {
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        songArtistLabel.translatesAutoresizingMaskIntoConstraints = false
        lyricsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            songTitleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            songTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            songArtistLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 10),
            songArtistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            lyricsTextView.topAnchor.constraint(equalTo: songArtistLabel.bottomAnchor, constant: 20),
            lyricsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lyricsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lyricsTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

private extension LyricsView {
    @objc func didTapBackButton() {
        presenter?.navigateBack()
    }
}
