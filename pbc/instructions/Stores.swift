//
//  Stores.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// Stores (0x3)
// ssotre istore lstore fstore dstore tstore

let storesCategory: Int8 = 0x3
/*
class BaseStore: BaseInstruction {
    init(subByteCode: Int8, operand: ExpressionOperandElement) {
        super.init(categoryCode: storesCategory, subByteCode: subByteCode, operands: [operand])
    }
    
    static func select(_ operand: ExpressionOperandElement) throws -> BaseInstruction {
        do {
            switch(operand.type) {
            case .short:
                return try SStore(operand)
            case .int:
                return try IStore(operand)
            case .long:
                return try LStore(operand)
            case .float:
                return try FStore(operand)
            case .double:
                return try DStore(operand)
            case .string:
                return try TStore(operand)
            }
        } catch let error {
            throw error
        }
    }
}

class SStore: BaseStore {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .short else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 1, operand: operand)
    }
}

class IStore: BaseStore {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .int else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 2, operand: operand)
    }
}

class LStore: BaseStore {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .long else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 3, operand: operand)
    }
}

class FStore: BaseStore {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .float else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 4, operand: operand)
    }
}

class DStore: BaseStore {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .double else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 5, operand: operand)
    }
}

class TStore: BaseStore {
    init(_ operand: ExpressionOperandElement) throws {
        guard operand.type == .string else {
            throw DataTypeError("Wrong data type of operand")
        }
        super.init(subByteCode: 6, operand: operand)
    }
}
*/
