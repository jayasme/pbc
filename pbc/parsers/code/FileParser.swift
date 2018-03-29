//
//  CodeParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FileParserWatcher {
    var lineNumber: Int = 1
    var position: Int = 1
    var errors: [CompilingError] = []
    
    func appendError() {
        
    }
}

class FileParser {
    
    static var sharedCompound: CompoundStatementFragment? = nil
    
    static var sharedDeclareManager = DeclareManager()
    
    static var sharedWatcher: FileParserWatcher? = nil
    
    static func parseStatements(_ code: inout String) throws -> CompoundStatementFragment {
        do {
            let compound = try CompoundStatementParser.parse(&code)
            return compound
        } catch let error {
            print("At line " + String(sharedWatcher!.lineNumber))
            throw error
        }
    }
    
    static func parse(path: String) throws -> FileFragment? {
        do {
            let input = try CodeInput(path: path)
            let watcher = FileParserWatcher()
            FileParser.sharedWatcher = watcher
            let rootCompound = try FileParser.parseStatements(&input.code)
            return FileFragment(path: path, compound: rootCompound)
        } catch let error {
            print("Compiling aborted.")
            throw error
        }
    }
}
