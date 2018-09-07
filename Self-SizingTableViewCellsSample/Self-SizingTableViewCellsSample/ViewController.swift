//
//  ViewController.swift
//  Self-SizingTableViewCellsSample
//
//  Created by CityFruit on 2018/9/7.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(TSTableViewEmptyCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        let marginsGuide = self.view.layoutMarginsGuide
        
        let contraintsOfTableView = [
        tableView.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor)]
        
        NSLayoutConstraint.activate(contraintsOfTableView)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TSTableViewEmptyCell

        return cell
    }
}
