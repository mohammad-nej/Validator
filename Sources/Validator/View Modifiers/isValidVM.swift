//
//  isValidVM.swift
//  Validator
//
//  Created by MohammavDev on 4/25/25.
//

import SwiftUI
import Foundation


 struct isValidVM : ViewModifier {
    
    @Environment(ViewIdentifier.self) var viewId
    @Environment(\.validationManager) var manager
    
    @Binding var isValid: Bool
     init(_ isValid : Binding<Bool>){
        self._isValid = isValid
    }
    public func body(content: Content) -> some View {
        content
            .onAppear {

                guard let manager else {
                    logger.error( "ValidationManager not found. use `.validationManager()` modifier on this view hierarchy to set a ValidationManager ")
                    return}
                let results =  manager.validate(view: viewId)
                isValid = results.isValid
            }
            .onChange(of: manager?.latesResults){
                guard let manager else {
                    logger.error( "ValidationManager not found. use `.validationManager()` modifier on this view hierarchy to set a ValidationManager ")
                    return
                }
                guard let latest = manager.latesResults else {
                    
                    
                    return
                }
                guard !latest.results.isEmpty else { isValid = true ; return}
                for result in latest.results{
                    guard result.relatedView == viewId else { continue }
                    self.isValid = result.isValid
                    guard isValid else { return }
                }
            }
          
    }
}
