//
//  ContentView.swift
//  VggExample
//
//  Created by houguanhua on 2023/11/16.
//

import SwiftUI
import VggRuntime

struct VggJsCounter: View {
    var body: some View {
        if let filePath = Bundle.main.path(forResource: "counter_with_js",
                                           ofType: "daruma",
                                           inDirectory: "Assets") {
            let vggViewModel = VggViewModel(filePath: filePath)
            return AnyView( VStack(alignment: .center) {
                vggViewModel.view()
                NavigationLink("Open another vgg js counter") { VggJsCounter() }
                Spacer()
            })
            
        } else {
            return AnyView(
                VStack {
                    Text("Please provide vgg file")
                }
                    .padding())
        }

    }
    
}
