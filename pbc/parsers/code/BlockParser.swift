//
//  BlockParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/2.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class BlockElement: FragmentElement {
    var fragments: [FragmentElement]
    var variableManager: VariableManager
    var typeManager: TypeManager
    var tagManager: TagManager
    
    init(parentBlock: BlockElement? = nil, fragments: [FragmentElement] = []) {
        self.fragments = fragments
        self.variableManager = VariableManager(parentManager: parentBlock?.variableManager)
        self.typeManager = TypeManager(parentManager: parentBlock?.typeManager)
        self.tagManager = TagManager(parentManager: parentBlock?.tagManager)
    }
}

class BlockParser {
    
    static func parse(
        _ code: inout String,
        lineNumber: inout Int32,
        didCreateBlock: ((_ block: BlockElement) throws -> Void)? = nil,
        shouldEndStatement: ((_ statement: BaseStatement, _ block: BlockElement) -> Bool)? = nil
    ) throws -> BlockElement {
        do {
            let parentBlock = CodeParser.sharedBlock
            let block = BlockElement(parentBlock: parentBlock)
            CodeParser.sharedBlock = block
            
            try didCreateBlock?(block)
            
            var newLine = true
            
            while (code.count > 0) {
                
                if let separator = SeparatorParser.parse(&code) {
                    if (separator.separatorType == .newLine) {
                        lineNumber += 1
                        newLine = true
                    }
                    continue
                }
                
                // parse line tag
                // tag only appeared at the beginning of a line
                if newLine, let tag = TagParser.parse(&code) {
                    block.fragments.append(tag)
                    newLine = false
                    continue
                }
                
                // parse the single statement
                if let fragment = try FragmentParser.parse(&code, lineNumber: &lineNumber) {
                    // end of the block
                    if let statement = fragment as? StatementElement, shouldEndStatement?(statement.statement, block) == true {
                        break
                    }
                    block.fragments.append(fragment)
                }
            }
            
            CodeParser.sharedBlock = parentBlock
            return block
        } catch let error {
            throw error
        }
    }
}
