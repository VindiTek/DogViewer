//
//  UITableViewCell+Extension.swift
//  Do a Wilson
//
//  Created by Dmytro Antonchenko on 2/26/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

protocol CellInitializing {}

extension UITableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
} 

extension UITableViewCell: CellInitializing {}

extension CellInitializing where Self: UITableViewCell {
    static func dequeueFromTableView(_ tableView: UITableView) -> Self {
        let identifier = cellIdentifier
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! Self
        return cell
    }
}

