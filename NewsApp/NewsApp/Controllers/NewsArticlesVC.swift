//
//  NewsArticlesVC.swift
//  NewsApp
//
//  Created by Mondale on 5/13/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class NewsArticlesVC: UIViewController {

    var articles: [Article] = []
    var selectedCategory: String = ""
    var page = 1
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getNewsArticles()
    }
    

    private func configureViewController(){
        title = selectedCategory
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }

    
    func getNewsArticles(){
        NetworkManager.shared.getArticles(for: selectedCategory, page: page) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.articles.append(contentsOf: articles)
                self.page += 1
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.rawValue)
                let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert,animated: true)
            }
        }
    }
    
    
}

extension NewsArticlesVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsUrl = articles[indexPath.row].url
        let newsDetailPage = DetailVC()
        newsDetailPage.url = newsUrl
        navigationController?.pushViewController(newsDetailPage, animated: true)
    }
    

}

extension NewsArticlesVC : UITableViewDataSource {
    
    // Handles pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            
            self.getNewsArticles()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseID, for: indexPath) as! ArticleCell
        let article = articles[indexPath.row]
        
        cell.articleTitleLabel.text = article.title
        cell.downloadImage(from: article.urlToImage)
        return cell
    }
    
    
}
