//
//  TSPresentationViewController.swift
//  UIViewControllerPresentationSample
//
//  Created by CityFruit on 2018/9/10.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit

class TSPresentationViewController: UIViewController {
    
    let viewController: UIViewController
    
    let titleLabel: UILabel = UILabel()
    
    var insets: UIEdgeInsets = UIEdgeInsets.zero
    
    init(viewController: UIViewController) {
        
        self.viewController = viewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 模态控制器的显示区域是全屏
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.backgroundColor = UIColor(red: 54/255, green: 72/255, blue: 94/255, alpha: 1)
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .white
        self.view.addSubview(self.titleLabel)
        
        let contentView = self.viewController.view!
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        
        self.titleLabel.text = self.viewController.title
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor,
                                                 constant: self.insets.top),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                constant: -self.insets.bottom)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                     constant: self.insets.left),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                      constant: -self.insets.right),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                 constant: self.insets.left),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                  constant: -self.insets.right)
        ])
    }
}
