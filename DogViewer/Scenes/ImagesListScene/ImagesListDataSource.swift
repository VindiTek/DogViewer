//
//  ImagesListDataSource.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit
import SDWebImage

final class ImagesListDataSource: NSObject, UITableViewDataSource {
    
    //MARK: - Open Properties
    var cellIdentifiers: [String] {
        return [ImageCell.cellIdentifier]
    }
    
    //MARK: - Closed Properties
    private var cellsData: [String] = []
    
    //MARK: - Open
    func updateCellsData(cellsData: [String]) {
        self.cellsData = cellsData
        SDWebImagePrefetcher.shared().prefetchURLs(cellsData.map{URL(string: $0)}.compactMap{$0})
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ImageCell.dequeueFromTableView(tableView)
        cell.update(withImageString: cellsData[indexPath.row])
        return cell
    }
    
}
