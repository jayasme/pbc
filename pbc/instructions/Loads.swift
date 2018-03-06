//
//  Loads.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// Loads (0x1)
// sload iload lload fload dload tload

let loadsCategory: Int8 = 0x1
/*
class BaseLoad: BaseInstruction {
    init(subByteCode: Int8, operand: OperandElement) {
        super.init(categoryCode: loadsCategory, subByteCode: subByteCode, operands: [operand])
    }
    
    static func select(_ operand: OperandElement) throws -> BaseInstruction {
        do {
            switch(operand.type) {
            case .short:
                return try SLoad(operand)
            case .int:
                return try ILoad(operand)
            case .long:
                return try LLoad(operand)
            case .float:
                return try FLoad(operand)
            case .double:
                return try DLoad(operand)
            case .string:
                return try TLoad(operand)
            }
        } catch let error {
            throw error
        }
    }
}

class SLoad: BaseLoad {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .short else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 1, operand: operand)
    }
}

class ILoad: BaseLoad {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .int else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 2, operand: operand)
    }
}

class LLoad: BaseLoad {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .long else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 3, operand: operand)
    }
}

class FLoad: BaseLoad {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .float else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 4, operand: operand)
    }
}

class DLoad: BaseLoad {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .double else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 5, operand: operand)
    }
}

class TLoad: BaseLoad {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .string else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 6, operand: operand)
    }
}

*/
