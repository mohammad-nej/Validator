//
//  ViewIdentifier.swift
//  Validator
//
//  Created by MohammavDev on 4/25/25.
//

import Foundation



/// A type used to identify each view. You have to assign it to any view that you want to validate.
///
/// ```swift
///     @State private var viewId : ViewIdentifier = .init()
///     var body : some View {
///         TextFeild("sample Text",$text)
///         .validation{
///             return text.isEmpty ? "Text shouldn't be empty" : ""
///          }
///          .environment(viewId)
@Observable
public final class ViewIdentifier : Identifiable , Equatable  {
 
    public static func == (lhs: ViewIdentifier, rhs: ViewIdentifier) -> Bool {
        lhs.id == rhs.id
    }
    public static func == (lhs:ViewIdentifier , rhs: UUID?) -> Bool {
        guard let rhs else { return false}
        return lhs.id == rhs
    }
    
 
    public static func == (lhs:UUID? , rhs: ViewIdentifier) -> Bool {
        guard let lhs else { return false}
        return lhs == rhs.id
    }
    
    
    public init(id : UUID){
        self.id = id
    }
    public init() {
        self.id = UUID()
    }
    public var id : UUID
}

extension UUID : @retroactive Identifiable {
    public var id : Self {
        self
    }
}
