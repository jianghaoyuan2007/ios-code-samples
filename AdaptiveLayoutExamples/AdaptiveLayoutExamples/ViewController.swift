//
//  ViewController.swift
//  AdaptiveLayoutExamples
//
//  Created by CityFruit on 2018/9/15.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layoutGuide = UILayoutGuide()
        self.view.addLayoutGuide(layoutGuide)
        
        if #available(iOS 11.0, *) {
            let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                layoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                layoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                layoutGuide.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor),
                layoutGuide.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor),
                layoutGuide.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                layoutGuide.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
        
        let exampleView = UIView()
        exampleView.backgroundColor = .yellow
        exampleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(exampleView)
        
        NSLayoutConstraint.activate([
            exampleView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            exampleView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            exampleView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            exampleView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        ])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

