//
//  UITest.swift
//  Validator
//
//  Created by MohammavDev on 4/28/25.
//

//
//  TestView.swift
//  Validator
//
//  Created by MohammavDev on 4/25/25.
//

import SwiftUI
import Validator

public struct TestView: View {
    
    
    @State private var viewId = ViewIdentifier()
    @State private var text: String = ""
    @State private var text2: String = ""
    @State private var flag = false
    
    public init(){}
    
    @State private var isValid : Bool = true
    @State private var results : ValidationResult = .init()
    @State var manager = ValidationManager()
    public var body: some View {
        VStack{
            
            Text("Validation Result : \(results)")
       
            TextField("Enter text2", text: $text2)
                .padding()
                
                .validation {
                    text2.isEmpty ? "این فیلد ضروری است" : ""
                }
                .isValid($isValid)
                .environment(viewId)
            Toggle("Flag", isOn: $flag)
            
            Button("Validate"){
                results = manager.validate()
            }
        }.validationManager()
            .textFieldStyle(.roundedBorder)
    }
}
#Preview {
    TestView()
}
