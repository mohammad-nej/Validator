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
                   guard let validationManager else {
                       logger.error( "ValidationManager not found. use `.validationManager()` modifier on this view hierarchy to set a ValidationManager ")
                       return
                   }
                   if let closure{
                       //Creating a single validator
                       let createdOne = Validation(closure: closure)
                       createdOne.relatedView = viewIdentifier.id
                   
                       validationManager.validators.append(createdOne)
                   }else if let closures{
                    
                       guard closures.count > 0 else { return }
                       logger.debug("Creating \(closures.count) validators...")
                       validationManager.validators.append(contentsOf: closures.map{
                           let validation = Validation(closure: $0)
                           validation.relatedView = viewIdentifier.id
                           return validation
                       })
                   }
               }
       }
   
//    }
    
}
