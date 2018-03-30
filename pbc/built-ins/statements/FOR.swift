//
//  FOR.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FORStatement: BaseStatement, CompoundStatement {
    static var name: String {
        get {
            return "FOR"
        }
    }
    
    static var keywords: [String] {
        get {
            return ["FOR"]
        }
    }
    
    static func endStatement(statement: BaseStatement) -> Bool {
        return statement is NEXTStatement
    }
    
    func beginStatement(compound: CompoundStatementFragment) throws {
        // register the counter
        try compound.variableManager.registerVariable(self.counter)
    }

    var counter: Variable
    var start: Operand
    var end: Operand
    var step: Operand
    
    init(counter: Variable, start: Operand, end: Operand, step: Operand) {
        self.counter = counter
        self.start = start
        self.end = end
        self.step = step
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        // parse the counter name
        guard let counterName = PatternedNameParser.parse(&code)?.name else {
            throw InvalidNameError("Expected a valid variable name")
        }
        
        // parse the counter type
        var counterType: TypeTuple! = nil
        if (KeywordParser.parse(&code, keyword: "AS") != nil) {
            guard let type = FileParser.sharedCompound?.typeManager.parseType(&code) else {
                throw InvalidTypeError("Unexpected a data type.")
            }
            counterType = TypeTuple(type)
        }
        
        // parse the '='
        guard (SymbolParser.parse(&code, symbol: "=") != nil) else {
            throw SyntaxError.Expected(syntax: "=")
        }
        
        // parse the start
        guard let start = try ExpressionParser.parse(&code)?.value else {
            throw SyntaxError.Illegal_Expression_After(syntax: "=")
        }
        if (counterType == nil) {
            counterType = start.type
        }
        
        // check the start's type
        guard start.type.isNumber else {
            throw InvalidValueError("Only numbers are excepted as the start value of a FOR loop statement.")
        }
        
        guard start.type.isCompatibleWith(type: counterType) else {
            throw InvalidTypeError("The type of counter '" + start.type.name + "' dismatches to the start value.")
        }
        
        // parse the 'TO'
        guard (KeywordParser.parse(&code, keyword: "TO") != nil) else {
            throw SyntaxError.Expected(syntax: "TO")
        }
        
        // parse the end
        guard let end = try ExpressionParser.parse(&code)?.value else {
            throw SyntaxError.Illegal_Expression_After(syntax: "TO")
        }
        
        // check the end's type
        guard end.type.isNumber else {
            throw InvalidTypeError("Only numbers are excepted as the end value of a FOR loop statement.")
        }
        
        // parse the step
        var step: Operand! = nil
        if (KeywordParser.parse(&code, keyword: "STEP") != nil) {
            guard let se = try ExpressionParser.parse(&code)?.value else {
                throw SyntaxError.Illegal_Expression_After(syntax: "STEP")
            }
            step = se
        }
        if (step == nil) {
            step = ConstantOperand(Constant(value: 1, type: counterType))
        }
        
        // check the step's type
        guard step.type.isNumber else {
            throw InvalidTypeError("Only numbers are excepted as the step of a FOR loop statement.")
        }
        
        let counter = Variable.init(name: counterName, type: counterType!)
        return FORStatement(counter: counter, start: start, end: end, step: step)
    }
}
