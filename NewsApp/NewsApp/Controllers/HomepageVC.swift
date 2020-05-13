//
//  HomepageVC.swift
//  NewsApp
//
//  Created by Mondale on 5/12/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class HomepageVC: UIViewController {

    enum Section {
        case main
    }

    let categoryList:[String] = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    var filteredCategory: [String] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        updateData(on: categoryList)
        configureSearchController()
    }
    

    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        collectionView.delegate = self
    }

    
    // Helper function that creates a Two Column Flowlayout
    private func createTwoColumnFlowLayout() -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat = 24
        let minimumItemSpacing: CGFloat = 20
        let availableWidth = width - (padding * 2) - minimumItemSpacing
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        return flowLayout
    }
    
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, category) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
            cell.categoryLabel.text = self.categoryList[indexPath.row]
            return cell
        })
    }
    
    
    func updateData(on followers: [String]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        self.dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a category"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
}

extension HomepageVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = self.categoryList[indexPath.row]
        
        let newsArticlesVC = NewsArticlesVC()
        newsArticlesVC.selectedCategory = selectedCategory
        self.navigationController?.pushViewController(newsArticlesVC, animated: true)
    }
}

extension HomepageVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        print(filter)
        filteredCategory = categoryList.filter { $0.lowercased().contains(filter.lowercased()) }
        print(filteredCategory)
        updateData(on: filteredCategory)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: categoryList)
    }
}
