//
//  AllDogsBreedListConfigurator.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

final class AllDogsBreedListConfigurator {
    
    class func configure(_ controller: AllDogsBreedListVC) {
        let router = AllDogsBreedListRouter()
        router.controller = controller
        controller.router = router
    }
    
}
