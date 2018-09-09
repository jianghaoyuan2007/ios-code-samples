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
        tableView.register(TSTableViewTwoLabelsCell.self,
                           forCellReuseIdentifier: "TSTableViewTwoLabelsCell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        let marginsGuide: UILayoutGuide
        if #available(iOS 11.0, *) {
            marginsGuide = self.view.safeAreaLayoutGuide
        } else {
            marginsGuide = self.view.layoutMarginsGuide
        }
        
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
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TSTableViewTwoLabelsCell") as! TSTableViewTwoLabelsCell
            let value1 = "多行文本的固有内容尺寸"
            let value2 = """
UILabel 和 NSTextField 对于多行文本的固有内容尺寸是模糊不清的。文本的高度取决于行的宽度，这也是解决约束条件时需要弄清的问题。为了解决这个问题，这两个类都有一个叫做 preferredMaxLayoutWidth 的新属性，这个属性指定了行宽度的最大值，以便计算固有内容尺寸。
"""
            cell.configure(title: value1, value: value2)
            return cell
    }

        
        return UITableViewCell()
    }
}
