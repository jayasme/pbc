//
//  IOError.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class IOError: InnerError {
    
    static func Input_Path_Not_Specified() -> IOError {
        return IOError("Input path not specified.")
    }
    
    static func Output_Path_Not_Specified() -> IOError {
        return IOError("Output path not specified.")
    }
    
    static func Input_File_Does_Not_Exist(path: String) -> IOError {
        return IOError(String(format: "Input file '%@' does not exist", path))
    }
    
    static func Fail_To_Open_File(path: String) -> IOError {
        return IOError(String(format: "Failed to open '%@'", path))
    }
    
    static func Incorrect_File_Encoding(path: String) -> IOError {
        return IOError(String(format: "Cannot decode from file '%@', Please make sure the file was encoding under UTF8.", path))
    }
}

