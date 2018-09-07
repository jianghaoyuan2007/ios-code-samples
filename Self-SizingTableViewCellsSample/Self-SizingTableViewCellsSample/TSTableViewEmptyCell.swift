//
//  TSTableViewEmptyCell.swift
//  Self-SizingTableViewCellsSample
//
//  Created by CityFruit on 2018/9/7.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit

class TSTableViewEmptyCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .gray
        
        let emptyLayoutGuide = UILayoutGuide()
        self.contentView.addLayoutGuide(emptyLayoutGuide)
        
        let marginsGuide = self.contentView.layoutMarginsGuide
        
        var constraintsOfEmptyView = [
        emptyLayoutGuide.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
        emptyLayoutGuide.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
        // UITableViewCell 会根据 ContentView 中的内容进行自动计算行高，但要设置与 ContentView 的 bottomAnchor 和 topAnchor 的代码
        // top == bottom == 8
        emptyLayoutGuide.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
        emptyLayoutGuide.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor)]
        
        // 该约束用来撑起整体的高度，为了避免约束的冲突，设置了一个相对较低的优先级
        let heightConstraintOfEmptyView = emptyLayoutGuide.heightAnchor.constraint(equalToConstant: 28)
        heightConstraintOfEmptyView.priority = .defaultHigh
        constraintsOfEmptyView.append(heightConstraintOfEmptyView)
        
        NSLayoutConstraint.activate(constraintsOfEmptyView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
