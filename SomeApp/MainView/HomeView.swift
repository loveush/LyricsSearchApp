//
//  HomeView.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 24.01.2025.
//

import UIKit

protocol HomeViewProtocol: BaseViewProtocol {
    
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
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - View Components
    private let button = CustomButton(title: "Search lyrics")
    private lazy var titleLabel = CustomTitleLabel(label: presenter?.greeting ?? "Hello!")
}

//MARK: - Setting Views
private extension HomeView {
    func setUpView() {
        addSubViews()
        setUpLayout()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
}

//MARK: - Subviews
private extension HomeView {
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(button)
    }
}

//MARK: - Layout
private extension HomeView {
    func setUpLayout() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
}

//MARK: - Button action
private extension HomeView {
    @objc func didTapButton() {
        let vc = Builder.createSearchView()
        navigationController?.pushViewController(vc, animated: true)
    }
}
