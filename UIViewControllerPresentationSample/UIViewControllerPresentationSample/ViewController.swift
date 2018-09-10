//
//  ViewController.swift
//  UIViewControllerPresentationSample
//
//  Created by CityFruit on 2018/9/10.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 1)) {
            
            let vc = TSPresentationViewController(viewController: TSInformationType1ViewController())
            vc.modalPresentationStyle = .overCurrentContext
            vc.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            UIView.animate(withDuration: 0.5, animations: {
                self.tabBarController?.present(vc, animated: true, completion: nil)
            })
        }
    }
    

}

