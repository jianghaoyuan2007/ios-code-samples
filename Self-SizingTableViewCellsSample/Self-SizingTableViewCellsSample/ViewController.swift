//
//  ViewController.swift
//  Self-SizingTableViewCellsSample
//
//  Created by CityFruit on 2018/9/7.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(TSTableViewEmptyCell.self,
                           forCellReuseIdentifier: "TSTableViewEmptyCell")
        tableView.register(TSTableViewBasicCell.self,
                           forCellReuseIdentifier: "TSTableViewBasicCell")
        tableView.register(TSTableViewTextViewCell.self,
                           forCellReuseIdentifier: "TSTableViewTextViewCell")
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
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TSTableViewEmptyCell") as! TSTableViewEmptyCell
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TSTableViewBasicCell") as! TSTableViewBasicCell
            cell.configure(title: "类型", value: "SELECTED")
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TSTableViewBasicCell") as! TSTableViewBasicCell
            cell.configure(title: "类型", value: "SELECTED", textAlignment: .left)
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TSTableViewTextViewCell") as! TSTableViewTextViewCell
            cell.configure(title: "描述", textView: self.textView)
            cell.maximumInputTextLength = 5
            return cell
        }
        
        return UITableViewCell()
    }
}
