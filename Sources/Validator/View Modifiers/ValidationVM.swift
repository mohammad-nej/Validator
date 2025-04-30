//
//  ValidationVM.swift
//  Validator
//
//  Created by MohammavDev on 4/25/25.
//

import SwiftUI


struct ValidationVM : ViewModifier {
    
    @Environment(\.validationManager) var validationManager
    @Environment(ViewIdentifier.self) private var viewIdentifier
    
    let closure : (() -> String)?
    let closures : [() -> String]?
 
    
    init(_ closure : @escaping () -> String){
        self.closure = closure
        self.closures = nil
        
    }
    init(_ closures : [() -> String]){
        self.closure = nil
        self.closures = closures
    }
    public func body(content: Content) -> some View {
        
        content
            .onAppear{
                logger.debug("Inserting a new Validator...")
                guard let validationManager else {
                    logger.error( "ValidationManager not found. use `.validationManager()` modifier on this view hierarchy to set a ValidationManager ")
                    return
                }
                if let closure{
                    //Creating a single validator
                    logger.debug("Validation created for view : \(viewIdentifier.id.uuidString)")
                    let createdOne = Validation(closure: closure)
                    createdOne.relatedView = viewIdentifier.id
                    
                    validationManager.validators.insert(createdOne)
                }else if let closures{
                    
                    guard closures.count > 0 else { return }
                    logger.debug("Creating \(closures.count) validators...")
                    let validators = closures.map{
                        let validation = Validation(closure: $0)
                        validation.relatedView = viewIdentifier.id
                        return validation
                    }
                    validators.forEach { validator in
                        validationManager.validators.insert(validator)
                    }
                    logger.debug("\(closures.count) Validations(s) created for view : \(viewIdentifier.id.uuidString)")
                }
            }
    }
    
    //    }
    
}
