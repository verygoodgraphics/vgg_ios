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
            delegate.vggModel = vggViewModel.vggModel;
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
    weak var vggModel: VggModel?
    
    func handleVggEvent(_ type: String, path: String) {
        print("swift handle vgg event:", type, path)
        
        guard let model = vggModel else {
            return
        }
        
        switch path {
        case "/frames/0/childObjects/1":
            fallthrough
        case "/frames/0/childObjects/2":
            let buttonPath = "/frames/0/childObjects/1/style/fills/0/color/alpha"
            switch type {
            case "touchstart":
                model.designDocReplace(at: buttonPath, value: "1.0")
                
            case "touchend":
                model.designDocReplace(at: buttonPath, value: "0.5")
                
                var count = 0
                
                let valuePath = "/frames/0/childObjects/3/content"
                if let jsonString = model.designDocValue(at: valuePath),
                   let countString = try? JSONSerialization.jsonObject(with: Data(jsonString.utf8),
                                                                 options: [.fragmentsAllowed]) as? String,
                    let lastCount = Int(countString) {
                    count = lastCount
                }
                
                count += 1
                model.designDocReplace(at: valuePath,
                                       value: "\"\(count)\"")
            default:
                break
            }
        default:
            break
        }
        
    }
}

