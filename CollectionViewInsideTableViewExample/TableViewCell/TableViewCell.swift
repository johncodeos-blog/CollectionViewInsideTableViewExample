//
//  TableViewCell.swift
//  CollectionViewInsideTableViewExample
//
//  Created by John Codeos on 12/20/19.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: TableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

class TableViewCell: UITableViewCell {
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    var rowWithColors: [CollectionViewCellModel]?
    
    @IBOutlet var subCategoryLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        self.subCategoryLabel.textColor = UIColor.white
        
        // TODO: need to setup collection view flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 180)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        
        // Comment if you set Datasource and delegate in .xib
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "collectionviewcellid")
    }
}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // The data we passed from the TableView send them to the CollectionView Model
    func updateCellWith(row: [CollectionViewCellModel]) {
        self.rowWithColors = row
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        print("I'm tapping the \(indexPath.item)")
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowWithColors?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath) as? CollectionViewCell {
            cell.colorView.backgroundColor = self.rowWithColors?[indexPath.item].color ?? UIColor.black
            cell.nameLabel.text = self.rowWithColors?[indexPath.item].name ?? ""
            return cell
        }
        return UICollectionViewCell()
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
