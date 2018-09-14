//
//  ViewController.swift
//  RxSwiftMemoryManagement
//
//  Created by CityFruit on 2018/9/14.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 1)) {
            
            self.navigationController?.pushViewController(TSViewController(), animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

