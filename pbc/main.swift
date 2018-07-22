//
//  main.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// acquire the arguments
ConfigurationManager.shared = try ConfigurationManager.init(arguments: ProcessInfo.processInfo.arguments)
    
let file = FileParser.parse(path: ConfigurationManager.shared.inputPath)
