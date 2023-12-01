//
//  ContentView.swift
//  VggExample
//
//  Created by houguanhua on 2023/11/16.
//

import SwiftUI
import VggRuntime

struct ContentView: View {
    var delegate = MyVggDegate()
    var body: some View {
        if let filePath = Bundle.main.path(forResource: "vgg",
                                           ofType: "daruma",
                                           inDirectory: "Assets") {
            let vggViewModel = VggViewModel(filePath: filePath,
                                            delegate: delegate)
            return AnyView(vggViewModel.view())
            
        } else {
            return AnyView(
                VStack {
                    Text("Please provide vgg file")
                }
                    .padding())
        }

    }
    
}

class MyVggDegate: VggDelegate {
    func handleVggEvent(_ type: String, path: String) {
        print(type, path)
    }
}

