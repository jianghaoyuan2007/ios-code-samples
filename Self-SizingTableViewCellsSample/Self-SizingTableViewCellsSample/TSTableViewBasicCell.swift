//
//  TSTableViewBasicCell.swift
//  Self-SizingTableViewCellsSample
//
//  Created by CityFruit on 2018/9/7.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit

class TSTableViewBasicCell: UITableViewCell {

    private var titleLabel = UILabel()
    private var valueLabel = UILabel()
    
    private var widthConstraintOfTitleLabel: NSLayoutConstraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .yellow

        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.backgroundColor = .red
        self.titleLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        self.titleLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        self.contentView.addSubview(self.titleLabel)
        
        self.valueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.valueLabel.textAlignment = .right
        self.valueLabel.font = UIFont.systemFont(ofSize: 14)
        self.valueLabel.textColor = .black
        self.valueLabel.backgroundColor = .green
        self.contentView.addSubview(self.valueLabel)
        
        let marginsGuide = self.contentView.layoutMarginsGuide
        
        let containerLayoutGuide = UILayoutGuide()
        self.contentView.addLayoutGuide(containerLayoutGuide)
        
        var constraintsOfContainer = [
            containerLayoutGuide.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            containerLayoutGuide.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
            containerLayoutGuide.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
            containerLayoutGuide.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor)]
        
        let heightConstraintOfContainer = containerLayoutGuide.heightAnchor.constraint(equalToConstant: 28)
        heightConstraintOfContainer.priority = UILayoutPriority.defaultHigh
        constraintsOfContainer.append(heightConstraintOfContainer)
        NSLayoutConstraint.activate(constraintsOfContainer)
        
        let constraintsOfTitleLabel = [
            self.titleLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraintsOfTitleLabel)

        let constraintsOfValueLabel = [
            self.valueLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10),
            self.valueLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
            self.valueLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
            self.valueLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraintsOfValueLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TSTableViewBasicCell {

    @objc func configure(title: String,
                         value: String,
                         accessoryType: UITableViewCellAccessoryType = .none,
                         userInteractionEnabled: Bool = true,
                         textAlignment: NSTextAlignment = .right) {
        
        self.titleLabel.text = title
        self.valueLabel.text = value
        self.valueLabel.textAlignment = textAlignment
        self.accessoryType = accessoryType
        self.isUserInteractionEnabled = userInteractionEnabled
        
        if textAlignment == .right {
            self.widthConstraintOfTitleLabel?.isActive = false
            self.widthConstraintOfTitleLabel = nil
        } else {
            self.widthConstraintOfTitleLabel = self.titleLabel.widthAnchor.constraint(equalToConstant: 80)
            self.widthConstraintOfTitleLabel?.isActive = true
        }
    }
}
