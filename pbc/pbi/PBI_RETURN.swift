//
//  Returns.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// Returns (0x11)
// sreturn ireturn lreturn freturn dreturn treturn

let returnsByteCode: Int8 = 0x11
/*
class BaseReturn: BaseInstruction {
    init(subByteCode: Int8) {
        super.init(categoryCode: loadsCategory, subByteCode: subByteCode, operands: [])
    }
    
    static func select(_ type: DataType? = nil) -> BaseInstruction {
        guard let type = type else {
            return Return()
        }
        
        switch(type) {
        case .short:
            return SReturn()
        case .int:
            return IReturn()
        case .long:
            return LReturn()
        case .float:
            return FReturn()
        case .double:
            return DReturn()
        case .string:
            return TReturn()
        }
    }
}

class Return: BaseReturn {
    init() {
        super.init(subByteCode: 0)
    }
}

class SReturn: BaseReturn {
    init() {
        super.init(subByteCode: 1)
    }
}

class IReturn: BaseReturn {
    init() {
        super.init(subByteCode: 2)
    }
}

class LReturn: BaseReturn {
    init() {
        super.init(subByteCode: 3)
    }
}

class FReturn: BaseReturn {
    init() {
        super.init(subByteCode: 4)
    }
}

class DReturn: BaseReturn {
    init() {
        super.init(subByteCode: 5)
    }
}

class TReturn: BaseReturn {
    init() {
        super.init(subByteCode: 6)
    }
}
*/
