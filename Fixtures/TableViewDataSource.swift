//
//  TableViewDataSource.swift
//  HeadlinesApp
//
//  Created by Ben Smith on 02/11/2018.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
class TableViewDataSource <Cell: UITableViewCell, ViewModel> : NSObject, UITableViewDataSource, UITableViewDelegate{
    private var cellIdentifier: String!
    var items:[ViewModel]!
    var configureCell:(Cell,ViewModel, IndexPath) -> ()

    init(cellIdentifier: String, items:[ViewModel], configureCell:@escaping (Cell,ViewModel, IndexPath) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.section]
        self.configureCell(cell, item, indexPath)
        return cell
    }

}

class TableViewDelegate <Cell: UITableViewCell, ViewModel> : NSObject, UITableViewDelegate{
    private var headerCellIdentifier: String!
    var items:[ViewModel]!
    var configureHeaderCell:(Cell,ViewModel, Int) -> ()

    init(headerCellIdentifier: String, items:[ViewModel], configureHeaderCell: @escaping (Cell,ViewModel, Int) -> ()) {
        self.items = items
        self.headerCellIdentifier = headerCellIdentifier
        self.configureHeaderCell = configureHeaderCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let matchHeaderCell = tableView.dequeueReusableCell(withIdentifier: self.headerCellIdentifier) as! Cell
        let item = self.items[section]
        self.configureHeaderCell(matchHeaderCell, item, section)
        return matchHeaderCell
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
