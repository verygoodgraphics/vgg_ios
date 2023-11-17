//
//  ContentView.swift
//  VggExample
//
//  Created by houguanhua on 2023/11/16.
//

import SwiftUI
import VggRuntime

struct ContentView: View {
    var body: some View {
        
        if let filePath = Bundle.main.path(forResource: "vgg", ofType: "daruma", inDirectory: "Assets") {
            return AnyView(VggViewModel(filePath: filePath).view())
            
        } else {
            return AnyView(
                VStack {
                    Text("Please provide vgg file")
                }
                    .padding())
        }

    }
}

