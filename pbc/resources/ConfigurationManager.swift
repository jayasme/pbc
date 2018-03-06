//
//  ConfigurationManager.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/13.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ConfigurationManager {
    
    static let INPUT_PATH_KEY: String = "INPUT_PATH_KEY"
    static let OUTPUT_PATH_KEY: String = "OUTPUT_PATH_KEY"
    static let CASE_SENSITIVE_KEY: String = "CASE_SENSITIVE"
    static let LINE_NUMBER_REQUIRED_KEY: String = "LINE_NUMBER_REQUIRED"
    
    var inputPath: String {
        set(value) {
            self.configurationMap[ConfigurationManager.INPUT_PATH_KEY] = value
        }
        get {
            return self.configurationMap[ConfigurationManager.INPUT_PATH_KEY] as! String
        }
    }
    
    var outputPath: String {
        set(value) {
            self.configurationMap[ConfigurationManager.OUTPUT_PATH_KEY] = value
        }
        get {
            return self.configurationMap[ConfigurationManager.OUTPUT_PATH_KEY] as! String
        }
    }
    
    var caseSensitive: Bool {
        set(value) {
            self.configurationMap[ConfigurationManager.CASE_SENSITIVE_KEY] = value
        }
        get {
            return self.configurationMap[ConfigurationManager.CASE_SENSITIVE_KEY] as! Bool
        }
    }
    
    var lineNumberRequired: Bool {
        set(value) {
            self.configurationMap[ConfigurationManager.LINE_NUMBER_REQUIRED_KEY] = value
        }
        get {
            return self.configurationMap[ConfigurationManager.LINE_NUMBER_REQUIRED_KEY] as! Bool
        }
    }
    
    static var shared: ConfigurationManager!
    
    private var configurationMap: [String: Any] = [:]
    
    init(arguments: [String]) throws {
        // -i is required
        guard let inputIndex = arguments.index(of: "-i") else {
            throw ArgumentError.init("Input path not specified.")
        }
        if (inputIndex == arguments.count) {
            throw ArgumentError.init("Input path not specified.")
        }
        
        /*
        // -o is required
        guard let outputIndex = arguments.index(of: "-o") else {
            throw ArgumentError.init("Output path not specified.")
        }
        if (outputIndex == arguments.count) {
            throw ArgumentError.init("Output path not specified.")
        } */
        
        configurationMap[ConfigurationManager.INPUT_PATH_KEY] = arguments[inputIndex + 1]
        // configurationMap[ConfigurationManager.OUTPUT_PATH_KEY] = arguments[outputIndex + 1]
        configurationMap[ConfigurationManager.CASE_SENSITIVE_KEY] = arguments.contains("-cs")
        configurationMap[ConfigurationManager.LINE_NUMBER_REQUIRED_KEY] = arguments.contains("-ln")
    }
    
    
}
