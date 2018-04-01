//
//  CodeParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FileParserWatcher {
    var filePath: String
    var lineNumber: Int = 1
    var position: Int = 1
    var errors: CompilingErrors = CompilingErrors()
    
    init(filePath: String) {
        self.filePath = filePath
    }
    
    func appendError(_ error: InnerError) {
        errors.errors.append(CompilingError(error, file: filePath, line: lineNumber, position: position))
    }
    
    func printErrors() {
        print(errors.description)
    }
}

class FileParser {
    
    static var sharedCompound: CompoundStatementFragment? = nil
    
    static var sharedDeclareManager = DeclareManager()
    
    static var sharedWatcher: FileParserWatcher? = nil
    
    static func parseStatements(_ code: inout String) throws -> CompoundStatementFragment {
        let compound = try CompoundStatementParser.parse(&code)
        return compound
    }
    
    static func parse(path: String) -> FileFragment? {
        do {
            let input = try CodeInput(path: path)
            FileParser.sharedWatcher = FileParserWatcher(filePath: path)
            let rootCompound = try FileParser.parseStatements(&input.code)
            // print the errors message
            FileParser.sharedWatcher?.printErrors()
            return FileFragment(path: path, compound: rootCompound)
        } catch let error {
            print("Fatal errors: " + error.localizedDescription)
            print("Compiling aborted.")
            return nil
        }
    }
}
