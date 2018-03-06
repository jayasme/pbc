//
//  CodeParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FragmentElement: BaseElement { }

class CodeElement: BaseElement {
    var rootBlock: BlockElement
    
    init(rootBlock: BlockElement) {
        self.rootBlock = rootBlock
    }
}

class CodeParser {
    
    static var sharedBlock: BlockElement? = nil
    
    static var sharedDeclareManager = DeclareManager()
    
    static func parseStatements(_ code: inout String) throws -> BlockElement {
        var lineNumber: Int32 = 1
        
        do {
            let block = try BlockParser.parse(&code, lineNumber: &lineNumber)
            return block
        } catch let error {
            print("At line " + String(lineNumber))
            throw error
        }
    }
    
    static func parse(_ code: inout String) throws -> CodeElement? {
        do {
            let rootBlock = try CodeParser.parseStatements(&code)
            return CodeElement(rootBlock: rootBlock)
        } catch let error {
            print("Compiling aborted.")
            throw error
        }
    }
}
