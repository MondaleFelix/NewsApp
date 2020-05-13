//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Mondale on 5/12/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class NetworkManager {
    
    // Creates singleton
    static let shared = NetworkManager()
    private init(){}
    

    let cache = NSCache<NSString, UIImage>()

    
    let baseURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=581b81ac72764f0b9375f1ce29dea721"
    
    
    func getArticles(for category: String, page:Int, completed: @escaping(Result<[Article], ErrorMessage>) -> Void){
        
        let endpoint = baseURL + "&category=\(category)&page=\(page)"
        
        // Returns if URL is invalid
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
    
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Returns if error exists
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            // Returns if response is not successful status code
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            // Returns if data is invalid
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // Trys to decode data, throws failure if invalid
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ArticleList.self, from: data)
                let articles = response.articles

                completed(.success(articles))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
//    func downloadImage(from urlString: String, completion: @escaping(UIImage)-> Void){
//        
//        let cacheKey = NSString(string: urlString)
//        
//        if let image = cache.object(forKey: cacheKey) {
//
//            return
//        }
//        
//        
//        guard let url = URL(string: urlString) else { return }
//        
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            
//            guard let self = self else { return }
//            
//            
//            if let _ = error { return }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
//            guard let data = data else { return }
//            
//            guard let image = UIImage(data: data) else { return }
//            
//            self.cache.setObject(image, forKey: cacheKey)
//            DispatchQueue.main.async {
//                self.image = image
//            }
//            
//        }
//        task.resume()
//    }

}
