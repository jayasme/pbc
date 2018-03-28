//
//  CodeParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FileParser {
    
    static var sharedCompound: CompoundStatementFragment? = nil
    
    static var sharedDeclareManager = DeclareManager()
    
    static func parseStatements(_ code: inout String) throws -> CompoundStatementFragment {
        var lineNumber: Int32 = 1
        
        do {
            let compound = try CompoundStatementParser.parse(&code, lineNumber: &lineNumber)
            return compound
        } catch let error {
            print("At line " + String(lineNumber))
            throw error
        }
    }
    
    static func parse(path: String) throws -> FileFragment? {
        do {
            let input = try CodeInput(path: path)
            let rootCompound = try FileParser.parseStatements(&input.code)
            return FileFragment(path: path, compound: rootCompound)
        } catch let error {
            print("Compiling aborted.")
            throw error
        }
    }
}
