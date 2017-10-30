//
//  LocalSongsCell.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 15.06.2017.
//  Copyright © 2017 KordianLedzion. All rights reserved.
//

import UIKit

class LocalSongsCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let releaseYearLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    private func setUp() {
        setUpConstraints()
        setUpTitleLabel()
    }
    
    private func setUpTitleLabel() {
        titleLabel.textAlignment = .left
    }
    
    private func setUpView() {
        separatorInset = .zero
        indentationWidth = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseYearLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
        releaseYearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        releaseYearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
        releaseYearLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
        releaseYearLabel.widthAnchor.constraint(equalToConstant: 48),
        
        titleLabel.trailingAnchor.constraint(equalTo: releaseYearLabel.leadingAnchor, constant: -6),
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
}
