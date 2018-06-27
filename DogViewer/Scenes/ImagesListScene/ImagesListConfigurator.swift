//
//  ImagesListConfigurator.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

final class ImagesListConfigurator {
    
    class func configure(_ controller: ImagesListVC) {
        let router = ImagesListRouter()
        router.controller = controller
        controller.router = router
    }
    
}
