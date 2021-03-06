//
//  TabBarController.swift
//  NativeKit
//
//  Created by Zhilei Zheng on 5/3/19.
//  Copyright © 2019 Zhilei Zheng. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let listVC = CoursesViewController()
        listVC.tabBarItem = UITabBarItem(title: "Courses", image: UIBarButtonItem.SystemItem.bookmarks.image(), tag: 0)
        let tabBarLists = [listVC]
        self.viewControllers = tabBarLists
        self.delegate = self
        self.view.backgroundColor = .white
    }

}

extension TabBarController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        self.title = viewController.title
//    }
}

extension UIBarButtonItem.SystemItem {
    func image() -> UIImage? {
        let tempItem = UIBarButtonItem(barButtonSystemItem: self,
                                       target: nil,
                                       action: nil)
        
        // add to toolbar and render it
        let bar = UIToolbar()
        bar.setItems([tempItem],
                     animated: false)
        bar.snapshotView(afterScreenUpdates: true)
        
        // got image from real uibutton
        let itemView = tempItem.value(forKey: "view") as! UIView
        for view in itemView.subviews {
            if let button = view as? UIButton,
                let image = button.imageView?.image {
                return image.withRenderingMode(.alwaysTemplate)
            }
        }
        
        return nil
    }
}
