//
//  AllDogsBreedListDataSource.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

final class AllDogsBreedListDataSource: NSObject, UITableViewDataSource {
    
    //MARK: - Open Properties
    var cellIdentifiers: [String] {
        return [DogBreedCell.cellIdentifier]
    }
    
    //MARK: - Closed Properties
    private var cellsData: [DogBreed] = []
    
    //MARK: - Open
    func updateCellsData(cellsData: [DogBreed]) {
        self.cellsData = cellsData
    }
    
    func dogBreed(for indexPath: IndexPath) -> DogBreed {
        return cellsData[indexPath.row]
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DogBreedCell.dequeueFromTableView(tableView)
        cell.textLabel?.text = cellsData[indexPath.row].name
        cell.detailTextLabel?.text = cellsData[indexPath.row].subBreed.isEmpty ? nil : "Has subbreeds"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
