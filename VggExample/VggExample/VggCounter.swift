/*
 * Copyright 2023-2024 VeryGoodGraphics LTD <bd@verygoodgraphics.com>
 *
 * Licensed under the VGG License, Version 1.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.verygoodgraphics.com/licenses/LICENSE-1.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
    
    func handleVggEvent(_ type: String, targetId: String, targetName: String) {
        print("swift handle vgg event:", type, targetId, targetName)
        
        switch targetName {
        case "#counterButtonText":
            fallthrough
        case "#counterButton":
            switch type {
            case "touchstart":
                updateElement(id: "#counterButton", alpha: 1.0)
                
            case "touchend":
                updateElement(id: "#counterButton", alpha: 0.5)
                updateCountText(id: "#count")
                
            default:
                break
            }
        default:
            break
        }
        
    }
    
    func updateElement(id:String, alpha:Float) {
        guard let vggContainer = vggContainer else { return }
        guard let e = vggContainer.element(byId: id) else { return }
        
        if var o = try? JSONSerialization.jsonObject(with: Data(e.utf8)) as? [String:Any] {
            if var style = o["style"] as? [String:Any] {
                if var fills = style["fills"] as? [Any] {
                    if var fill = fills[0] as? [String:Any] {
                        if var color = fill["color"] as? [String:Any]{
                            color["alpha"] = alpha
                            fill["color"]  = color
                        }
                        fills[0] = fill
                    }
                    style["fills"] = fills
                }
                o["style"] = style
            }
            if let d = try? JSONSerialization.data(withJSONObject: o) {
                let s = String(decoding: d, as: UTF8.self)
                vggContainer.updateElement(byId:id, content: s)
            }
        }
    }
    
    func updateCountText(id:String) {
        guard let vggContainer = vggContainer else { return }
        guard let e = vggContainer.element(byId: id) else { return }
        
        if let o = try? JSONSerialization.jsonObject(with: Data(e.utf8)) as? [String:Any] {
            var count = 0
            if let content = o["content"] as? String, let lastCount = Int(content) {
                count = lastCount
            }
            count += 1
            let patch = ["content": String(count)]
            if let d = try? JSONSerialization.data(withJSONObject: patch) {
                let s = String(decoding: d, as: UTF8.self)
                vggContainer.updateElement(byId:id, content: s)
            }
        }
    }
}

