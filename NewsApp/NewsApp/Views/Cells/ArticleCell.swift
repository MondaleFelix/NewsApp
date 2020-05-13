//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Mondale on 5/13/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    static let reuseID = "ArticleCell"
    
    var articleTitleLabel = UILabel()
    var articleImageView: UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    
    private func configureTitleLabel(){
        addSubview(articleTitleLabel)
        articleTitleLabel.textColor = .black
        articleTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        articleTitleLabel.numberOfLines = 0
        articleTitleLabel.lineBreakMode = .byWordWrapping
        articleTitleLabel.sizeToFit()
        articleTitleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
        
            articleTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            articleTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            articleTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
    
    
    private func configureImageView(){
        
    }
}
