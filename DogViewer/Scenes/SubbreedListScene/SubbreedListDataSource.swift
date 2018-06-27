//
//  SubbreedListDataSource.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

final class SubbreedListDataSource: NSObject, UITableViewDataSource {
    
    //MARK: - Open Properties
    var cellIdentifiers: [String] {
        return [SubBreedCell.cellIdentifier]
    }
    
    //MARK: - Closed Properties
    fileprivate var cellsData: [String] = []
    
    //MARK: - Open
    func updateCellsData(cellsData: [String]) {
        self.cellsData = cellsData
    }
    
    func subbreed(for indexPath: IndexPath) -> String {
        return cellsData[indexPath.row]
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SubBreedCell.dequeueFromTableView(tableView)
        cell.textLabel?.text = cellsData[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
