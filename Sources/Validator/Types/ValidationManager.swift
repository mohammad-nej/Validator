//
//  ValidationManager.swift
//  Validator
//
//  Created by MohammavDev on 4/25/25.
//
import SwiftUI

@Observable
public final class ValidationManager {
    
    public init(){}
    ///All validators on this manager
    var  validators : [Validation] = []
    
    ///result of the latest validation check done by the manager
    public var latesResults : ValidationResult?
    
    ///All errorMessages produced by the validation
    public var errorsMessages : [String] {
        guard let latesResults else { return []}
        return latesResults.results.map{$0.reason}
    }
    ///Run Validation only for you selected view
    /// - Parameter id: the unique of your view
    /// - Returns: Validation result including error message(s) and the final result
    public func validate(view id : ViewIdentifier) -> ValidationResult {
        var results = ValidationResult()
        for validator in validators where validator.relatedView == id {
            if validator.validate() == false {
                results.results.append(validator)
            }
        }
        latesResults = results
        return results
    }
    
    ///Run all the validations
    public func validate() -> ValidationResult {
        var results = ValidationResult()
         logger.debug("validators count : \(self.validators.count.description)")
         for validator in validators {
            if validator.validate() == false {
                results.results.append(validator)
            }
        }
         latesResults = results
         return results
    }
    
    
}
