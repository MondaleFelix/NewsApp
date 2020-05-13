//
//  CategoryCell.swift
//  NewsApp
//
//  Created by Mondale on 5/12/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    
    static let reuseID = "CategoryCell"
    var categoryLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        contentView.layer.cornerRadius = 10
        addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.textAlignment     = .center
        categoryLabel.font              = UIFont.systemFont(ofSize: 20, weight: .regular)
        categoryLabel.textColor         = .label
        categoryLabel.clipsToBounds = true
        contentView.backgroundColor = .systemGray5

        

        
        
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            categoryLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
    }

}
