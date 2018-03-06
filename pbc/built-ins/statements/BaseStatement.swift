//
//  BaseStatement.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/16.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

protocol BaseStatement: class {
    static var name: String { get }
    static var keywords: [String] { get }
    static func parse(_ code: inout String) throws -> BaseStatement?
}

protocol GroupedStatement: class {
    static func endStatement(statement: BaseStatement) -> Bool
    // Optional
    func beginStatement(block: BlockElement) throws
    static var blockIncludesBeginStatement: Bool { get }
    static var blockIncludesEndStatement: Bool { get }
}

extension GroupedStatement {
    func beginStatement(block: BlockElement) throws { }
    static var blockIncludesBeginStatement: Bool {
        get {
            return true
        }
    }
    static var blockIncludesEndStatement: Bool {
        get {
            return true
        }
    }
}
