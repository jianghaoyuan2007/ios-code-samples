//
//  TSViewController.swift
//  RxSwiftMemoryManagement
//
//  Created by CityFruit on 2018/9/14.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit
import RxSwift

class TSViewController: UIViewController {

    let name = Variable<String>.init("")
    let type = Variable<String>.init("")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        Observable.combineLatest(self.name.asObservable(), self.type.asObservable())
            .map { return $0.0 }
            .subscribe(onNext: { print($0)})
            .disposed(by: self.disposeBag)
    }
    
    deinit {
        print("\(self.title ?? self.description)_deinit.")
    }
}
