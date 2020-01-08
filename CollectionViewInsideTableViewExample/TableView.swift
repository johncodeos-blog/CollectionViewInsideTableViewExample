//
//  ViewController.swift
//  CollectionViewInsideTableViewExample
//
//  Created by John Codeos on 12/20/19.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import UIKit

class TableView: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var colorsArray = Colors()
    var tappedCell: CollectionViewCellModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.colorFromHex("#9E1C40")
        tableView.separatorStyle = .none
        
        // Register the xib for tableview cell
        let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "tableviewcellid")
    }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return colorsArray.objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsArray.objectsArray[section].subcategory.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // Category Title
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.colorFromHex("#BC224B")
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 44))
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = colorsArray.objectsArray[section].category
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as? TableViewCell {
            // Show SubCategory Title
            let subCategoryTitle = colorsArray.objectsArray[indexPath.section].subcategory
            cell.subCategoryLabel.text = subCategoryTitle[indexPath.row]

            // Pass the data to colletionview inside the tableviewcell
            let rowArray = colorsArray.objectsArray[indexPath.section].colors[indexPath.row]
            cell.updateCellWith(row: rowArray)

            // Set cell's delegate
            cell.cellDelegate = self
            
            cell.selectionStyle = .none
            return cell
       }
        return UITableViewCell()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsviewcontrollerseg" {
            let DestViewController = segue.destination as! DetailsViewController
            DestViewController.backgroundColor = tappedCell.color
            DestViewController.backgroundColorName = tappedCell.name
        }
    }
}

extension TableView: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: TableViewCell) {
        if let colorsRow = didTappedInTableViewCell.rowWithColors {
            self.tappedCell = colorsRow[index]
            performSegue(withIdentifier: "detailsviewcontrollerseg", sender: self)
            // You can also do changes to the cell you tapped using the 'collectionviewcell'
        }
    }
}
