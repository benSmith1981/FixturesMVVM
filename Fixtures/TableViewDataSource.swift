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
    private var headerCellIdentifier: String!
    var items:[ViewModel]!
    var configureCell:(Cell,ViewModel, IndexPath) -> ()
    var configureHeaderCell:(Cell,ViewModel, Int) -> ()

    init(headerCellIdentifier: String, cellIdentifier: String, items:[ViewModel], configureCell:@escaping (Cell,ViewModel, IndexPath) -> (), configureHeaderCell: @escaping (Cell,ViewModel, Int) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
        self.headerCellIdentifier = headerCellIdentifier
        self.configureHeaderCell = configureHeaderCell
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
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Test"
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let matchHeaderCell = tableView.dequeueReusableCell(withIdentifier: self.headerCellIdentifier) as! Cell
        let item = self.items[section]
        self.configureHeaderCell(matchHeaderCell, item, section)
        return matchHeaderCell
        
    }
}
