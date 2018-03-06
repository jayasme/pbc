//
//  Array+Utils.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/28.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

extension Array {
    
    func afterAll(index: Int) -> [Element] {
        guard index < self.count - 1 else {
            return []
        }
        
        return Array(self[(index + 1)...])
    }
    
    func beforeAll(index: Int) -> [Element] {
        guard index > 0 else {
            return []
        }
        
        return Array(self[0..<index])
    }
}
