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

struct VggJsExample: View {
    var fileName:String = "prototype3"
    
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

