//
//  Base.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI {
    var bytecode: Int16
    
    init(catecode: Int8, opercode: Int8) {
        self.bytecode = Int16(catecode) << 8 & Int16(opercode)
    }
}

class PBI_STACK_POOL {
    private var items: [PBI_POOL_ITEM] = []
    
    func appendElement(element: PBI_ELEMENT) {
        let item = PBI_POOL_ITEM.init(sequence: items.count, element: element)
        items.append(item)
    }
    
    func element(bySequence sequence: Int) -> PBI_ELEMENT? {
        if (sequence >= 0 && sequence < items.count && items[sequence].sequence == sequence) {
            return items[sequence].element
        }
        
        return nil
    }
    
    func element(byName name: String) -> PBI_ELEMENT? {
        return items.first { $0.element.name == name }?.element
    }
    
    func discard() {
        items.removeAll()
    }
}

class PBI_POOL_ITEM {
    var sequence: Int
    var element: PBI_ELEMENT
    
    init(sequence: Int, element: PBI_ELEMENT) {
        self.sequence = sequence
        self.element = element
    }
}

class PBI_ELEMENT {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class PBI_VARIABLE: PBI_ELEMENT {
    var type: Type
    
    init(_ name: String, type: Type) {
        self.type = type
        super.init(name: name)
    }
}

class PBI_LINETAG: PBI_ELEMENT {
    init(_ name: String) {
        super.init(name: name)
    }
}

class PBI_FIELD: PBI_ELEMENT {
    var type: Type
    
    init(_ name: String, type: Type) {
        self.type = type
        super.init(name: name)
    }
}
