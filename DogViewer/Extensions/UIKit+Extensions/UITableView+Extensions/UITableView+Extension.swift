//
//  UITableView+Extension.swift
//  Do a Wilson
//
//  Created by Dmytro Antonchenko on 2/26/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCells(with identifiers: [String]) {
        identifiers.forEach { (identifer) in
            self.register(UINib(nibName: identifer, bundle: nil), forCellReuseIdentifier: identifer)
        }
    }
    
    func hideLastSeparator() {
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 1))
        self.tableFooterView?.backgroundColor = .clear
    }
}
