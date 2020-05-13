//
//  Article.swift
//  NewsApp
//
//  Created by Mondale on 5/13/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import Foundation

struct Article: Codable {
    var title: String
    var url: String
    var urlToImage: String?
}

struct ArticleList: Codable {
    var articles: [Article]
}
