//
//  Validataion.swift
//  Validator
//
//  Created by MohammavDev on 4/25/25.
//
import Foundation
import SwiftUI

@Observable
 class Validation  :  Hashable ,Equatable , Identifiable{
    
     
     
    let id : UUID = UUID()
    
    var closure : () -> String
    var relatedView : UUID? = nil
    private var _isValid : Bool?
     var isValid : Bool {
        if let _isValid{
            return _isValid
        }
        return validate()
    }
    var reason : String = ""
    init(closure: @escaping () -> String) {
        self.closure = closure
    }
    
    func validate() -> Bool {
        var result : [String] = []
      
        logger.debug("single item validation is beggining")
        
        let answer = closure()
        if !answer.isEmpty{
            result.append(answer)
            reason = answer
        }
        
        _isValid = result.isEmpty
        return _isValid!
    }
}
extension Validation {
    
     static func == (lhs: Validation, rhs: Validation) -> Bool {
        return lhs.id == rhs.id
    }
     func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
