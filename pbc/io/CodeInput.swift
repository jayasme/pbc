//
//  Input.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class CodeInput {
    
    var path: String
    var code: String
    
    init(path: String) throws {
        self.path = path
        
        if (!FileManager.default.fileExists(atPath: path)) {
            throw IOError("Input file does not exist: " + path)
        }
        
        guard let stream = InputStream(fileAtPath: path) else {
            throw IOError("Fail to open file: " + path)
        }
        
        var data = Data.init()
        
        stream.open()
        let bufferSize = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while (stream.hasBytesAvailable) {
            let read = stream.read(buffer, maxLength: bufferSize)
            data.append(buffer, count: read)
        }
        buffer.deallocate(capacity: bufferSize)

        guard let code = String.init(data: data, encoding: .utf8) else {
            throw IOError("Can not decode from file " + path + ", Please make sure the files is using the UTF8 encode.")
        }
        self.code = code
    }
}
