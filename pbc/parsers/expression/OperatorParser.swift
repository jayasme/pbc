//
//  ExpOperatorParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class OperatorElement: BaseElement {
    var oper: Operator
    
    init(_ oper: Operator) {
        self.oper = oper
    }
}

class OperatorParser {
    
    static func parse(_ code: inout String, preferUnary: Bool = false) -> OperatorFragment? {
        if (!preferUnary && SymbolParser.parse(&code, symbol: "+") != nil) {
            return OperatorFragment(.addition)
        } else if (!preferUnary && SymbolParser.parse(&code, symbol: "-") != nil) {
            return OperatorFragment(.subtract)
        } else if (SymbolParser.parse(&code, symbol: "*") != nil) {
            return OperatorFragment(.multiply)
        } else if (SymbolParser.parse(&code, symbol: "/") != nil) {
            return OperatorFragment(.division)
        } else if (SymbolParser.parse(&code, symbol: "^") != nil) {
            return OperatorFragment(.square)
        } else if (SymbolParser.parse(&code, symbol: "\\") != nil) {
            return OperatorFragment(.intDivision)
        } else if (KeywordParser.parse(&code, keyword: "MOD") != nil) {
            return OperatorFragment(.modulo)
        } else if (KeywordParser.parse(&code, keyword: "AND") != nil) {
            return OperatorFragment(.and)
        } else if (KeywordParser.parse(&code, keyword: "OR") != nil) {
            return OperatorFragment(.or)
        } else if (KeywordParser.parse(&code, keyword: "NOT") != nil) {
            return OperatorFragment(.not)
        } else if (KeywordParser.parse(&code, keyword: "XOR") != nil) {
            return OperatorFragment(.xor)
        } else if (KeywordParser.parse(&code, keyword: "EQV") != nil) {
            return OperatorFragment(.eqv)
        } else if (SymbolParser.parse(&code, symbol: "=") != nil) {
            return OperatorFragment(.equal)
        } else if (SymbolParser.parse(&code, symbol: "<>") != nil) {
            return OperatorFragment(.notEqual)
        } else if (SymbolParser.parse(&code, symbol: "<=") != nil) {
            return OperatorFragment(.lessOrEqual)
        } else if (SymbolParser.parse(&code, symbol: ">=") != nil) {
            return OperatorFragment(.greaterOrEqual)
        } else if (SymbolParser.parse(&code, symbol: "<") != nil) {
            return OperatorFragment(.less)
        } else if (SymbolParser.parse(&code, symbol: ">") != nil) {
            return OperatorFragment(.greater)
        } else if (preferUnary && SymbolParser.parse(&code, symbol: "+") != nil) {
            return OperatorFragment(.positive)
        } else if (preferUnary && SymbolParser.parse(&code, symbol: "-") != nil) {
            return OperatorFragment(.negative)
        }
        return nil
    }
}
