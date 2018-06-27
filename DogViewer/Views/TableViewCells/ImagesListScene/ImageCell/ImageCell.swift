//
//  ImageCell.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCell: UITableViewCell {

    @IBOutlet private weak var dogImageView: UIImageView!
    
    
    func update(withImageString path: String) {
        dogImageView.sd_setImage(with: URL(string: path))
    }
}
