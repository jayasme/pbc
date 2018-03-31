//
//  BaseManager.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

protocol BaseManagerContent {
    var name: String { get }
}

class BaseManager<T: BaseManagerContent> {
    
    private(set) var map: [String: T] = [:]
    private(set) var parentManager: BaseManager<T>?
    
    init(parentManager: BaseManager<T>? = nil) {
        self.parentManager = parentManager
    }
    
    func registerValue(_ value: T) throws {
        let name = value.name
        guard (self.findValue(name) == nil) else {
            throw InvalidNameError.Redeclaration_Of(name: name)
        }
        
        self.map[ConfigurationManager.shared.caseSensitive ? name : name.uppercased()] = value
    }
    
    func findValue(_ name: String) -> T? {
        if let value = self.map[ConfigurationManager.shared.caseSensitive ? name : name.uppercased()] {
            return value
        }
        
        return self.parentManager?.findValue(name)
    }
    
    func clear() {
        self.map.removeAll()
    }
}
