//
//  TSTabBarController.swift
//  iPhoneXUITabBar
//
//  Created by CityFruit on 2018/9/14.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect0: CGRect = CGRect(x: 0.0, y: 0.0, width: Double(size.width), height: Double(size.height - 20))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect0)
        let rect1: CGRect = CGRect(x: 0.0, y: Double(size.height - 20), width: Double(size.width), height: 20)
        UIColor.clear.setFill()
        UIRectFill(rect1)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}


class TSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UITabBar.appearance().barTintColor = .green

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tabWidth = (tabBar.frame.width/CGFloat(tabBar.items!.count))
        let tabHeight = tabBar.frame.height
        self.tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.blue, size: CGSize(width: tabWidth, height: tabHeight)).resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}
