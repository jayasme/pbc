//
//  StatementFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class BaseStatementFragment: BaseFragment {
    
    var isSingleStatement: Bool {
        return self is SingleStatementFragment
    }

    var isCompoundStatement: Bool {
        return self is CompoundStatementFragment
    }
}

class SingleStatementFragment: BaseStatementFragment {
    
    var statement: BaseStatement
    
    init(_ statement: BaseStatement) {
        self.statement = statement
    }
    
}

class CompoundStatementFragment: BaseStatementFragment {
    var statements: [BaseStatementFragment]
    var variableManager: VariableManager
    var typeManager: TypeManager
    var tagManager: TagManager
    
    var firstStatement: BaseStatement? {
        return (self.statements.first as? SingleStatementFragment)?.statement
    }
    
    init(parent: CompoundStatementFragment? = nil) {
        self.statements = []
        self.variableManager = VariableManager(parentManager: parent?.variableManager)
        self.typeManager = TypeManager(parentManager: parent?.typeManager)
        self.tagManager = TagManager(parentManager: parent?.tagManager)
    }
}

