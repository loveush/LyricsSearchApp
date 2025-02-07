//
//  CustomTitleLabel.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import UIKit

final class CustomTitleLabel: UILabel {
    
    // MARK: - Initializers
    init(label: String) {
        super.init(frame: .zero)
        setupTitleLabel(label: label)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupTitleLabel(label: String) {
        text = label
        font = .boldSystemFont(ofSize: 28)
        textAlignment = .center
        textColor = .white
        numberOfLines = 1
        translatesAutoresizingMaskIntoConstraints = false
    }
}
