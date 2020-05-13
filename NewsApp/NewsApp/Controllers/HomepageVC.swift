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

    let categoryList = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        updateData()
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
    func createTwoColumnFlowLayout() -> UICollectionViewFlowLayout{
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
    
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categoryList)
        self.dataSource.apply(snapshot, animatingDifferences: true)
        
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
