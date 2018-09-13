//
//  TSOption.swift
//  SimpleOptionsList
//
//  Created by CityFruit on 2018/9/13.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import Foundation

struct TSOption: Equatable {
    
    let code: String
    
    let name: String
    
    let index: Int
    
    static func == (lhs: TSOption, rhs: TSOption) -> Bool {
        
        return lhs.code == rhs.code && lhs.name == rhs.name && lhs.index == rhs.index
    }
}

extension Array where Element == TSOption {
    
    @discardableResult
    mutating func po_remove(item: TSOption) -> TSOption? {
    
        guard let index = self.index(of: item) else { return nil }
        
        return self.remove(at: index)
    }
}
