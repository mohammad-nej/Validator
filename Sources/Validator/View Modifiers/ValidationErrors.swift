//
//  AssignIdVM.swift
//  Validator
//
//  Created by MohammavDev on 4/25/25.
//

import SwiftUI

import Foundation


struct ValidationErrors : ViewModifier{
    @Environment(ViewIdentifier.self) private var viewId
    @Environment(\.validationManager) private var manager
    
    @Binding var result : [String]
    init(_ result : Binding<[String]>){
        self._result = result
    }
    func body(content: Content) -> some View {
        content
            .onChange(of:manager?.latesResults){
        
                guard let manager else {
                    logger.error( "ValidationManager not found. use `.validationManager()` modifier on this view hierarchy to set a ValidationManager ")
                    return}
                guard let result = manager.latesResults else {
                    self.result = []
                    return
                }
                guard manager.latesResults?.results.isEmpty == false else {
                    self.result = []
                    return }
                
                self.result = result.results.compactMap{ value in
                    if value.relatedView == viewId{
                        return value.reason
                    }
                    return nil
                }
            }
            
    }
}
