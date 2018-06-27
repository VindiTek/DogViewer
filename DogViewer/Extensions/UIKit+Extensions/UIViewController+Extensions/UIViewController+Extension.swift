//
//  UIViewController+Extension.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

protocol StoryboardInitializing {}
extension UIViewController: StoryboardInitializing {}
private extension UIViewController {
    static var className: String {
        return String(describing: self)
    }
}

extension StoryboardInitializing where Self: UIViewController {
    
    static func instantiate(with storyboardId: StoryboardId) -> Self {
        let vcIdentifier = className
        
        let storyboard = UIStoryboard(name: storyboardId.rawValue, bundle: nil) as UIStoryboard?
        assert(storyboard != nil, "Storyboard name is incorrect")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: vcIdentifier)
        assert(vc != nil, "ViewController id name is incorrect")
        
        return vc as! Self
    }
    
    static func instantiate(with storyboardId: StoryboardId, viewIdentifier: String) -> Self {
        
        let storyboard = UIStoryboard(name: storyboardId.rawValue, bundle: nil) as UIStoryboard?
        assert(storyboard != nil, "Storyboard name is incorrect")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: viewIdentifier)
        assert(vc != nil, "ViewController id name is incorrect")
        
        return vc as! Self
    }
    
    static func instantiate() -> Self {
        let storyboardID = ControllersId(rawValue: className)?.storyboardId
        assert(storyboardID != nil, "storyboard id is nil")
        return instantiate(with: storyboardID!)
    }
    
}
