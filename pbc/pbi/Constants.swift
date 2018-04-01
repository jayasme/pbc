//
//  Constants.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// Constants (0x2)
// sconstant iconstant lconstant fconstant dconstant tconstant

let constantsByteCode: Int8 = 0x2

/*
class BaseConstant: BaseInstruction {
    init(subByteCode: Int8, operand: OperandElement) {
        super.init(categoryCode: constantsByteCode, subByteCode: subByteCode, operands: [operand])
    }
    
    static func select(_ operand: OperandElement) throws -> BaseInstruction {
        do {
            switch(operand.type) {
            case .SHORTType:
                return try SConstant(operand)
            case .int:
                return try IConstant(operand)
            case .long:
                return try LConstant(operand)
            case .float:
                return try FConstant(operand)
            case .double:
                return try DConstant(operand)
            case .string:
                return try TConstant(operand)
            }
        } catch let error {
            throw error
        }
    }
}

class SConstant: BaseConstant {
    init(_ operand: OperandElement) throws {
        guard operand.type == .short else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 1, operand: operand)
    }
}

class IConstant: BaseConstant {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .int else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 2, operand: operand)
    }
}

class LConstant: BaseConstant {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .long else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 3, operand: operand)
    }
}

class FConstant: BaseConstant {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .float else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 4, operand: operand)
    }
}

class DConstant: BaseConstant {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .double else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 5, operand: operand)
    }
}

class TConstant: BaseConstant {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .string else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 6, operand: operand)
    }
}
 */
