//
//  TSTableViewTextViewCell.swift
//  Self-SizingTableViewCellsSample
//
//  Created by CityFruit on 2018/9/7.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit

class TSTableViewTextViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = UILabel()
    
    private var textView: UITextView?
    
    private var heightConstraintOfTextView: NSLayoutConstraint?
    
    var maximumInputTextLength: Int = 200
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.titleLabel)
        
        let marginsGuide = self.contentView.layoutMarginsGuide
        
        let contraintsOfTitleLabel = [
            self.titleLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 17)
        ]
        NSLayoutConstraint.activate(contraintsOfTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TSTableViewTextViewCell {
    
    @objc func configure(title: String, textView: UITextView) {
        
        self.titleLabel.text = title
        
        if let _textView = self.textView {
            
            _textView.removeConstraints(_textView.constraints)
            _textView.removeFromSuperview()
            _textView.translatesAutoresizingMaskIntoConstraints = true
            self.textView?.delegate = nil
            self.textView = nil
        }
        
        self.textView = textView
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textView)

        let marginsGuide = self.contentView.layoutMarginsGuide
        
        let constraintsOfTextView = [
            textView.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
            textView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            textView.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor),
            ]
        NSLayoutConstraint.activate(constraintsOfTextView)
        
        self.heightConstraintOfTextView = textView.heightAnchor.constraint(equalToConstant: 50)
        self.heightConstraintOfTextView?.priority = .defaultHigh
        self.heightConstraintOfTextView?.isActive = true
    }
}

extension TSTableViewTextViewCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        
        return newText.count < self.maximumInputTextLength
    }
}
