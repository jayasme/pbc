//
//  main.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// acquire the arguments
do {
    ConfigurationManager.shared = try ConfigurationManager.init(arguments: ProcessInfo.processInfo.arguments)
    
    let input = try CodeInput(path: ConfigurationManager.shared.inputPath)
    let code = try CodeParser.parse(&input.code)
    print("Parsing success")
}
catch let error {
    print((error as! InnerError).message)
}
