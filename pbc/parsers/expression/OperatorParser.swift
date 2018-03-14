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
    
    static func parse(_ code: inout String, preferUnary: Bool = false) -> OperatorElement? {
        if (!preferUnary && SymbolParser.parse(&code, symbol: "+") != nil) {
            return OperatorElement(Operator(.addition))
        } else if (!preferUnary && SymbolParser.parse(&code, symbol: "-") != nil) {
            return OperatorElement(Operator(.subtract))
        } else if (SymbolParser.parse(&code, symbol: "*") != nil) {
            return OperatorElement(Operator(.multiply))
        } else if (SymbolParser.parse(&code, symbol: "/") != nil) {
            return OperatorElement(Operator(.division))
        } else if (SymbolParser.parse(&code, symbol: "^") != nil) {
            return OperatorElement(Operator(.square))
        } else if (SymbolParser.parse(&code, symbol: "\\") != nil) {
            return OperatorElement(Operator(.intDivision))
        } else if (KeywordParser.parse(&code, keyword: "MOD") != nil) {
            return OperatorElement(Operator(.modulo))
        } else if (KeywordParser.parse(&code, keyword: "AND") != nil) {
            return OperatorElement(Operator(.and))
        } else if (KeywordParser.parse(&code, keyword: "OR") != nil) {
            return OperatorElement(Operator(.or))
        } else if (KeywordParser.parse(&code, keyword: "NOT") != nil) {
            return OperatorElement(Operator(.not))
        } else if (KeywordParser.parse(&code, keyword: "XOR") != nil) {
            return OperatorElement(Operator(.xor))
        } else if (KeywordParser.parse(&code, keyword: "EQV") != nil) {
            return OperatorElement(Operator(.eqv))
        } else if (SymbolParser.parse(&code, symbol: "=") != nil) {
            return OperatorElement(Operator(.equal))
        } else if (SymbolParser.parse(&code, symbol: "<>") != nil) {
            return OperatorElement(Operator(.notEqual))
        } else if (SymbolParser.parse(&code, symbol: "<=") != nil) {
            return OperatorElement(Operator(.lessOrEqual))
        } else if (SymbolParser.parse(&code, symbol: ">=") != nil) {
            return OperatorElement(Operator(.greaterOrEqual))
        } else if (SymbolParser.parse(&code, symbol: "<") != nil) {
            return OperatorElement(Operator(.less))
        } else if (SymbolParser.parse(&code, symbol: ">") != nil) {
            return OperatorElement(Operator(.greater))
        } else if (preferUnary && SymbolParser.parse(&code, symbol: "+") != nil) {
            return OperatorElement(Operator(.positive))
        } else if (preferUnary && SymbolParser.parse(&code, symbol: "-") != nil) {
            return OperatorElement(Operator(.negative))
        }
        return nil
    }
}
