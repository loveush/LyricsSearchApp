//
//  CustomTextField.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import UIKit

final class CustomTextField: UITextField {
    
    //MARK: - Private Property
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    
    
    // MARK: - Initializers
    init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    //MARK: - Private Methods
    private func setupTextField(placeholder: String) {
        layer.backgroundColor = UIColor.white.cgColor
        
        font = .boldSystemFont(ofSize: 18)
        attributedPlaceholder = NSAttributedString(string: placeholder)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
