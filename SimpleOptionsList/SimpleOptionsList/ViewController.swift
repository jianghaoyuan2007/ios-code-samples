//
//  ViewController.swift
//  SimpleOptionsList
//
//  Created by CityFruit on 2018/9/13.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton.init()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open", for: .normal)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    @objc func buttonTapped() {
        
        var options: [TSOption] = []
        
        options.append(TSOption.init(code: "1", name: "iPhone", index: 2))
        options.append(TSOption.init(code: "2", name: "iPad", index: 1))
        options.append(TSOption.init(code: "3", name: "MacBook Pro", index: 0))
        
        let vc = TSOptionsViewController.init(nibName: nil, bundle: nil)
        vc.options.value = options
        
        vc.selectedOptions.asObservable()
            .subscribe(onNext: { options in
                print(options)
            })
            .disposed(by: self.disposeBag)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

