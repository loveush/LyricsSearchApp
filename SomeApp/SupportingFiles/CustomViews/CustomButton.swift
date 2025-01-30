//
//  CustomButton.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import UIKit

final class CustomButton: UIButton {
    
    // MARK: - Initializers
    init(title: String) {
        super.init(frame: .zero)
        setupButton(title: title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupButton(title: String) {
        layer.backgroundColor = UIColor.geniusYellow.cgColor
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
