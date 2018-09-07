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
        
        let emptyView = UIView()
        emptyView.backgroundColor = UIColor.gray
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(emptyView)
        
        let marginsGuide = self.contentView.layoutMarginsGuide
        
        var constraintsOfEmptyView = [
        emptyView.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
        emptyView.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
        // UITableViewCell 会根据 ContentView 中的内容进行自动计算行高，但要设置与 ContentView 的 bottomAnchor 和 topAnchor 的代码
        emptyView.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
        emptyView.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor)]
        
        // 该约束用来撑起整体的高度，为了避免约束的冲突，设置了一个相对较低的优先级
        let heightConstraintOfEmptyView = emptyView.heightAnchor.constraint(equalToConstant: 50)
        heightConstraintOfEmptyView.priority = .defaultHigh
        constraintsOfEmptyView.append(heightConstraintOfEmptyView)
        
        NSLayoutConstraint.activate(constraintsOfEmptyView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
