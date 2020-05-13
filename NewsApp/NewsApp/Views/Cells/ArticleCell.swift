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
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    
    func downloadImage(from urlString: String?){

        guard let urlString = urlString else { return }

        let cache = NetworkManager.shared.cache
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            self.articleImageView?.image = image
            return
        }

        
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

            guard let self = self else { return }


            if let _ = error { return }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }

            guard let image = UIImage(data: data) else { return }

            cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.articleImageView?.image = image
            }

        }
        task.resume()
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
            articleTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -150),
            articleTitleLabel.heightAnchor.constraint(equalToConstant: 80),
            
        ])
    }
    
    
    private func configureImageView(){
        articleImageView = UIImageView()
        guard let articleImageView = articleImageView else { return }
        
        addSubview(articleImageView)
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.layer.cornerRadius = 100
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            articleImageView.leadingAnchor.constraint(equalTo: articleTitleLabel.trailingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            articleImageView.heightAnchor.constraint(equalToConstant: 80),

        ])
    }
    
    
}
