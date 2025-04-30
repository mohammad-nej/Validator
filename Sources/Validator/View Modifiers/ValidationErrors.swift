////
////  AssignIdVM.swift
////  Validator
////
////  Created by MohammavDev on 4/25/25.
////
//
//import SwiftUI
//
//import Foundation
//
//
//struct ValidationErrors : ViewModifier{
//    @Environment(ViewIdentifier.self) private var viewId
//    @Environment(\.validationManager) private var manager
//    
//    @Binding var result : [String]
//    init(_ result : Binding<[String]>){
//        self._result = result
//    }
//    func body(content: Content) -> some View {
//        content
//            .onChange(of:manager?.latesResults){
//        
//                guard let manager else {
//                    logger.error( "ValidationManager not found. use `.validationManager()` modifier on this view hierarchy to set a ValidationManager ")
//                    return}
//                guard let result = manager.latesResults else {
//                    self.result = []
//                    return
//                }
//                guard manager.latesResults?.results.isEmpty == false else {
//                    self.result = []
//                    return }
//                
//                let filtered = result.results.compactMap{ value in
//                    if value.relatedView == viewId{
//                        return value.reason
//                    }
//                    return nil
//                }
//                //Because manager.latesResults is updated every time that validate() or validate(view:) functions get called
//                //it's possible that this functions called rapidly multiple time. and if it get called for another view,
//                //it will override latesResults which might make it empty ( cause that other view might just validate)
//                //thus we don't update error messages.
//                if filtered.isEmpty{
//                    if let validatedViewId = result.viewId{
//                        //if validation was for another view we don't update
//                        guard validatedViewId == viewId else {return}
//                        self.result = []
//                    }else{
//                        // if result.viewId is nil, it means the validation was done for all views, thus we should update results
//                        self.result = []
//                    }
//                }
//                self.result = filtered
//            }
//            
//    }
//}
