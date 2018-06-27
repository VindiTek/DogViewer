//
//  ControllerHelper.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import Foundation

enum StoryboardId: String {
    case Main = "Main"
}

enum ControllersId: String {
    
    //MARK: - Main.storyboard
    case AllDogsBreedListVC = "AllDogsBreedListVC"
    case SubbreedListVC = "SubbreedListVC"
    case ImagesListVC = "ImagesListVC"
    
    var storyboardId: StoryboardId {
        switch self {
        case .AllDogsBreedListVC, .SubbreedListVC, .ImagesListVC:
            return .Main
        }
    }
}
