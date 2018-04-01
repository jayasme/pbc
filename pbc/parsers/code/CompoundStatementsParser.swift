//
//  BlockParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/2.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class CompoundStatementParser {
    
    static func parse(
        _ code: inout String,
        didCreateCompound: ((_ compound: CompoundStatementFragment) throws -> Void)? = nil,
        shouldEndStatement: ((_ statement: BaseStatement, _ compound: CompoundStatementFragment) -> Bool)? = nil
    ) throws -> CompoundStatementFragment {
        
        let parentCompound = FileParser.sharedCompound
        let compound = CompoundStatementFragment(parent: parentCompound)
        FileParser.sharedCompound = compound
        
        try didCreateCompound?(compound)
        
        var newLine = true
        
        while (code.count > 0) {
            
            do {
                if let separator = SeparatorParser.parse(&code) {
                    if (separator.separatorType == .newLine) {
                        FileParser.sharedWatcher?.lineNumber += 1
                        newLine = true
                    }
                    continue
                }
                
                // parse line tag
                // tag only appeared at the beginning of a line
                if newLine, let tag = TagDeclarationParser.parse(&code)?.tag {
                    try FileParser.sharedCompound?.tagManager.registerTag(Tag.init(tag))
                    newLine = false
                    continue
                }
                
                // parse the single statement
                if let statement = try StatementParser.parse(&code) {
                    // end of the block
                    if let subStatement = (statement as? SingleStatementFragment)?.statement, shouldEndStatement?(subStatement, compound) == true {
                        break
                    }
                    compound.statements.append(statement)
                }
            } catch let error {
                guard let innerError = error as? InnerError else {
                    throw error
                }
                
                FileParser.sharedWatcher?.appendError(innerError)
                EndOfLineParser.parse(&code)
                NewLineParser.parse(&code)
                FileParser.sharedWatcher?.lineNumber += 1
                newLine = true
            }
        }
        
        FileParser.sharedCompound = parentCompound
        return compound
    }
}
