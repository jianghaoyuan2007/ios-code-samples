//
//  TSTableViewTwoLabelsCell.swift
//  Self-SizingTableViewCellsSample
//
//  Created by Stephen Chiang on 2018/9/8.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit

class TSTableViewTwoLabelsCell: UITableViewCell {

    let label1: UILabel = UILabel()
    
    let label2: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.label1.translatesAutoresizingMaskIntoConstraints = false
        self.label1.numberOfLines = 0
        self.label1.font = UIFont.boldSystemFont(ofSize: 14)
        self.contentView.addSubview(self.label1)
        
        self.label2.translatesAutoresizingMaskIntoConstraints = false
        self.label2.numberOfLines = 0
        self.label2.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(self.label2)
        
        
        let marginsGuide = self.contentView.layoutMarginsGuide

        NSLayoutConstraint.activate ([
            self.label1.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            self.label1.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
            self.label1.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
            self.label1.heightAnchor.constraint(greaterThanOrEqualToConstant: 17)
        ])
        
        NSLayoutConstraint.activate ([
            self.label2.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            self.label2.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
            self.label2.topAnchor.constraint(equalTo: self.label1.bottomAnchor, constant: 5),
            self.label2.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor)
        ])
        
        let heightConstraintOfLabel2 = self.label2.heightAnchor.constraint(greaterThanOrEqualToConstant: 17)
        heightConstraintOfLabel2.priority = .defaultHigh
        heightConstraintOfLabel2.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TSTableViewTwoLabelsCell {
    
    func configure(title: String, value: String) {
        
        self.label1.text = title
        self.label1.backgroundColor = .yellow
        
        self.label2.text = value
        self.label2.backgroundColor = .green
    }
}
