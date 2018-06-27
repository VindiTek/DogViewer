//
//  SubbreedListConfigurator.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

final class SubbreedListConfigurator {
    
    class func configure(_ controller: SubbreedListVC) {
        let router = SubbreedListRouter()
        router.controller = controller
        controller.router = router
    }
    
}
