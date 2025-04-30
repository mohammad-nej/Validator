//
//  View Extensions.swift
//  Validator
//
//  Created by MohammavDev on 4/25/25.
//

import SwiftUI


public extension View {
    ///Attachs a single validation to this view
    /// - Warning: This will crash if you forget to set ViewIdentifier for your view
    func validation(_ closure : @escaping () -> String) -> some View {
        return modifier(ValidationVM(closure))
    }
    
    ///Attaches multiple validations to this view.
    /// - Warning: this will crash if you forget to set ViewIdentifier for your view
    func validation(_ closures : [ () -> String]) -> some View {
        return modifier(ValidationVM(closures))
    }
    

    ///Detect where this view is valid or not
    /// - Note:  You have to run `validate()` function in-order to get error messages
    /// - Warning: this will crash if you forget to set ViewIdentifier for your view
    func isValid(_ isValid : Binding<Bool>) -> some View {
        return modifier(isValidVM(isValid))
    }
    
    /// Insert a validationManager in to the view.
    ///
    ///
    /// You can access this object using Environment in your view heirarchy
    /// ```swift
    /// struct SampleView : View{
    ///     Environment(\.validationManager) private var manager
    ///     var body: some View {
    ///     ....
    ///     }
    /// }
    func validationManager(_ manager : ValidationManager = .init()) -> some View{
        return modifier(ValidationManagerVM(manager: manager))
    }
}
