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

protocol CompoundStatement: class {
    static func endStatement(statement: BaseStatement) -> Bool
    // Optional
    func beginStatement(compound: CompoundStatementFragment) throws
    static var compoundIncludesBeginStatement: Bool { get }
    static var compoundIncludesEndStatement: Bool { get }
}

extension CompoundStatement {
    func beginStatement(compound: CompoundStatementFragment) throws { }
    static var compoundIncludesBeginStatement: Bool {
        get {
            return true
        }
    }
    static var compoundIncludesEndStatement: Bool {
        get {
            return true
        }
    }
}
