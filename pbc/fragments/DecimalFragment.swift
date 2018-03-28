//
//  DecimalFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/28.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class DecimalFragment: BaseFragment {
    var value: Any
    var type: Type
    
    init(_ value: Any, type: Type) {
        self.value = value
        self.type = type
    }
    
    var shortValue: Int16 {
        return self.value as! Int16
    }
    
    var integerValue: Int32 {
        return self.value as! Int32
    }
    
    var longValue: Int64 {
        return self.value as! Int64
    }
    
    var floatValue: Float {
        return self.value as! Float
    }
    
    var doubleValue: Double {
        return self.value as! Double
    }
}
