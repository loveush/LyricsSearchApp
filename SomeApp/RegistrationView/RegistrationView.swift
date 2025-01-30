//
//  RegistrationView.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import UIKit

protocol RegistrationViewProtocol: BaseViewProtocol {
    
}

class RegistrationView: UIViewController, RegistrationViewProtocol {
    //MARK: - Presenter
    typealias PresenterType = RegistrationViewPresenterProtocol
    var presenter: PresenterType?
    
    //MARK: - Private Properties
    private let textField = CustomTextField(placeholder: "Enter your name...")
    private let submitButton = CustomButton(title: "Submit")

    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    
        setUpView()
    }
}

//MARK: - Setting Views
private extension RegistrationView {
    func setUpView() {
        addSubViews()
        setUpLayout()
    }
}

//MARK: - Subviews
private extension RegistrationView {
    func addSubViews() {
        view.addSubview(textField)
        view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
}

//MARK: - Layout
private extension RegistrationView {
    func setUpLayout() {

        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}

//MARK: - Button action
private extension RegistrationView {
    @objc func didTapButton() {
        presenter?.checkName(name: textField.text ?? "")
    }
}
