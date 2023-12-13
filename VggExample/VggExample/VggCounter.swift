//
//  VggCounter.swift
//  VggExample
//
//  Created by houguanhua on 2023/12/7.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

import SwiftUI

import VggRuntime

struct VggCounter: View {
    var delegate = MyVggDegate()
    var body: some View {
        if let filePath = Bundle.main.path(forResource: "counter_without_js",
                                           ofType: "daruma",
                                           inDirectory: "Assets") {
            let vggViewModel = VggViewModel(filePath: filePath,
                                            delegate: delegate)
            delegate.vggContainer = vggViewModel.vggContainer;
            
            return AnyView( VStack(alignment: .center) {
                vggViewModel.view()
                NavigationLink("Open another vgg counter") { VggCounter() }
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

class MyVggDegate: VggDelegate {
    weak var vggContainer: VggContainer?
    
    func handleVggEvent(_ type: String, path: String) {
        print("swift handle vgg event:", type, path)
        
        guard let vggContainer = vggContainer else {
            return
        }
        
        switch path {
        case "/frames/0/childObjects/1":
            fallthrough
        case "/frames/0/childObjects/2":
            let buttonPath = "/frames/0/childObjects/1/style/fills/0/color/alpha"
            switch type {
            case "touchstart":
                vggContainer.designDocReplace(at: buttonPath, value: "1.0")
                
            case "touchend":
                vggContainer.designDocReplace(at: buttonPath, value: "0.5")
                
                var count = 0
                
                let valuePath = "/frames/0/childObjects/3/content"
                if let jsonString = vggContainer.designDocValue(at: valuePath),
                   let countString = try? JSONSerialization.jsonObject(with: Data(jsonString.utf8),
                                                                 options: [.fragmentsAllowed]) as? String,
                    let lastCount = Int(countString) {
                    count = lastCount
                }
                
                count += 1
                vggContainer.designDocReplace(at: valuePath,
                                       value: "\"\(count)\"")
            default:
                break
            }
        default:
            break
        }
        
    }
}

