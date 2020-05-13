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
//        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    
    private func configureTitleLabel(){
        addSubview(articleTitleLabel)
        articleTitleLabel.textColor = .black
        articleTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        articleTitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        articleTitleLabel.numberOfLines = 0
        articleTitleLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
        
            articleTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            articleTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            articleTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            articleTitleLabel.heightAnchor.constraint(equalToConstant: 80),
            
        ])
    }
    
//
//    private func configureImageView(){
//        articleImageView = UIImageView()
//        guard let articleImageView = articleImageView else { return }
//        addSubview(articleImageView)
//        articleImageView.translatesAutoresizingMaskIntoConstraints = false
//        articleImageView.image = UIImage(named: "placeholder")
//
//        NSLayoutConstraint.activate([
//            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//
//            articleImageView.heightAnchor.constraint(equalToConstant: 25),
//
//        ])
//    }
}
