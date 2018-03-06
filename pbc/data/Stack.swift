//
//  Stack.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/5.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Stack<T> {
    
    private var innerList: [T] = []
    var top: T? {
        get {
            return self.innerList.last
        }
    }
    var count: Int {
        get {
            return self.innerList.count
        }
    }
    
    func push(_ value: T) {
        self.innerList.append(value)
    }
    
    func pop() -> T? {
        if let top = self.top {
            self.innerList.removeLast()
            return top
        }
        return nil
    }
    
}
