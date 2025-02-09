//
//  CustomCell.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 09.02.2025.
//

import UIKit

class CustomCell: UITableViewCell {
    // MARK: - UI components
    let title = UILabel()
    let artist = UILabel()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods
    private func setUpCell() {
        backgroundColor = .black
        
        title.textColor = .white
        title.font = .systemFont(ofSize: 20, weight: .bold)
        artist.textColor = .white
        artist.font = .systemFont(ofSize: 16)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        artist.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(title)
        contentView.addSubview(artist)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            artist.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            artist.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            artist.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            artist.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10) 
        ])
    }
}
