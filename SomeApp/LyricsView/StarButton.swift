//
//  StarButton.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 08.02.2025.
//

import UIKit

class StarButton: UIButton {
    //MARK: - Button conditions
    private let config = UIImage.SymbolConfiguration(pointSize: 24)
    private lazy var filledStar = UIImage(systemName: "star.fill", withConfiguration: config)
    private lazy var emptyStar = UIImage(systemName: "star", withConfiguration: config)

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    //MARK: - Private Methods
    private func setupButton() {
        setImage(emptyStar, for: .normal)
        setImage(filledStar, for: .selected)
        tintColor = .yellow
        translatesAutoresizingMaskIntoConstraints = false
    }

}
