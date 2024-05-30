//
//  VggJsExample.swift
//  VggExample
//
//  Created by houguanhua on 2024/5/30.
//  Copyright © 2024 VeryGoodGraphics LTD. All rights reserved.
//

import SwiftUI
import VggRuntime

struct VggJsExample: View {
    var fileName:String = "prototype1"
    
    var body: some View {
        if let filePath = Bundle.main.path(forResource: fileName,
                                           ofType: "daruma",
                                           inDirectory: "Assets") {
            let vggViewModel = VggViewModel(filePath: filePath)
            vggViewModel.vggContainer?.setFitToViewportEnabled(false)
            return AnyView( VStack(alignment: .center) {
                vggViewModel.view()
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

