//
//  ValidationResult.swift
//  Validator
//
//  Created by MohammavDev on 4/25/25.
//

///Holds the result of multiple validations.
public struct ValidationResult : Equatable{
    public init(){
        viewId = nil
    }
    public init(for viewId : ViewIdentifier?){
        self.viewId = viewId
    }
    var results : [Validation] = []
    
    ///Indicate whether this result, is for a specific viewId for not!
    let viewId : ViewIdentifier?
    
    public var errorMessages : [String] {
        return results.compactMap({ validation in
            if validation.reason.isEmpty == false{
                return validation.reason
            }
            return nil
        })
    }
    
    ///returns true if all validations are valid, false if at least on of the validations is failing'
   public  var isValid : Bool {
        for value in results{
            if value.isValid == false{
                return false
            }
        }
        return true
    }
    
}
