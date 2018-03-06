//
//  Tree.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class TreeNode<T> {
    var value: T?
    var children: [TreeNode] = []
    weak var parent: TreeNode? = nil
    
    init(_ value: T?, parent: TreeNode? = nil) {
        self.value = value
        self.parent = parent
    }
    
    func appendChild(_ node: TreeNode) {
        children.append(node)
        node.parent = self
    }
}

class Tree<T> {
    
    var root: TreeNode<T>
    
    init(rootValue: T?) {
        self.root = TreeNode<T>(rootValue)
    }
}
