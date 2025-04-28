//
//  ValidationManager.swift
//  Validator
//
//  Created by MohammavDev on 4/28/25.
//

import SwiftUI


struct ValidationManagerVM : ViewModifier{
    
    @State private var manager : ValidationManager
    
    init(manager : ValidationManager = .init()) {
        self._manager = .init(initialValue: manager)
    }
    
    func body(content: Content) -> some View {
        content
            .environment(\.validationManager, manager)
    }
}
