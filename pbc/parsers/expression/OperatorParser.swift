//
//  ExpOperatorParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

enum OperatorCategory {
    case mathematics
    case logic
    case comparation
}

enum OperatorOperands {
    case unary
    case binary
}

fileprivate let operatorsCategory: [OperatorType: OperatorCategory] = [
    .addition: .mathematics, .subtract: .mathematics, .multiply: .mathematics, .division: .mathematics, .square: .mathematics, .intDivision: .mathematics, .modulo: .mathematics, .positive: .mathematics, .negative: .mathematics,
    .and: .logic, .or: .logic, .not: .logic, .xor: .logic, .eqv: .logic,
    .equal: .comparation, .less: .comparation, .greater: .comparation, .lessOrEqual: .comparation, .greaterOrEqual: .comparation, .notEqual: .comparation
]

fileprivate let operatorsPiority: [OperatorType: Int] = [
    .not: 6, .positive: 6, .negative: 6,
    .square: 5,
    .multiply: 4, .division: 4, .modulo: 4, .intDivision: 4,
    .addition: 3, .subtract: 3,
    .equal: 2, .less: 2, .greater: 2, .lessOrEqual: 2, .greaterOrEqual: 2, .notEqual: 2,
    .and: 1, .or: 1, .xor: 1, .eqv: 1
]

class OperatorElement: BaseElement {
    var type: OperatorType
    var category: OperatorCategory {
        get {
            return operatorsCategory[self.type]!
        }
    }
    var operands: OperatorOperands {
        get {
            if (self.type == .not || self.type == .positive || self.type == .negative) {
                return .unary
            }
            return .binary
        }
    }
    var piority: Int {
        get {
            return operatorsPiority[self.type]!
        }
    }
    
    init(_ type: OperatorType) {
        self.type = type
    }
}

class OperatorParser {
    
    static func parse(_ code: inout String, preferUnary: Bool = false) -> OperatorElement? {
        if (!preferUnary && SymbolParser.parse(&code, symbol: "+") != nil) {
            return OperatorElement(.addition)
        } else if (!preferUnary && SymbolParser.parse(&code, symbol: "-") != nil) {
            return OperatorElement(.subtract)
        } else if (SymbolParser.parse(&code, symbol: "*") != nil) {
            return OperatorElement(.multiply)
        } else if (SymbolParser.parse(&code, symbol: "/") != nil) {
            return OperatorElement(.division)
        } else if (SymbolParser.parse(&code, symbol: "^") != nil) {
            return OperatorElement(.square)
        } else if (SymbolParser.parse(&code, symbol: "\\") != nil) {
            return OperatorElement(.intDivision)
        } else if (KeywordParser.parse(&code, keyword: "MOD") != nil) {
            return OperatorElement(.modulo)
        } else if (KeywordParser.parse(&code, keyword: "AND") != nil) {
            return OperatorElement(.and)
        } else if (KeywordParser.parse(&code, keyword: "OR") != nil) {
            return OperatorElement(.or)
        } else if (KeywordParser.parse(&code, keyword: "NOT") != nil) {
            return OperatorElement(.not)
        } else if (KeywordParser.parse(&code, keyword: "XOR") != nil) {
            return OperatorElement(.xor)
        } else if (KeywordParser.parse(&code, keyword: "EQV") != nil) {
            return OperatorElement(.eqv)
        } else if (SymbolParser.parse(&code, symbol: "=") != nil) {
            return OperatorElement(.equal)
        } else if (SymbolParser.parse(&code, symbol: "<>") != nil) {
            return OperatorElement(.notEqual)
        } else if (SymbolParser.parse(&code, symbol: "<=") != nil) {
            return OperatorElement(.lessOrEqual)
        } else if (SymbolParser.parse(&code, symbol: ">=") != nil) {
            return OperatorElement(.greaterOrEqual)
        } else if (SymbolParser.parse(&code, symbol: "<") != nil) {
            return OperatorElement(.less)
        } else if (SymbolParser.parse(&code, symbol: ">") != nil) {
            return OperatorElement(.greater)
        } else if (preferUnary && SymbolParser.parse(&code, symbol: "+") != nil) {
            return OperatorElement(.positive)
        } else if (preferUnary && SymbolParser.parse(&code, symbol: "-") != nil) {
            return OperatorElement(.negative)
        }
        return nil
    }
}
