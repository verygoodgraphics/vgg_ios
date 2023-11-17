//
//  VggViewModel.swift
//  VggRuntime
//
//  Created by houguanhua on 2023/11/16.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

import Foundation
import SwiftUI

open class VggViewModel {
    var vggModel: VggModel?
    var vggView: VggView?

    public init(
        filePath: String
    ) {
        vggModel = VggModel(filePath: filePath)
    }

    open func createVggView() -> VggView {
        let view: VggView
        
        if let model = vggModel {
            view = VggView(model: model)
        } else {
            view = VggView()
        }
        
        vggView = view
        
        return view
    }

    open func view() -> AnyView {
        return AnyView(VggViewRepresentable(viewModel: self))
    }

}

#if os(iOS)
    public struct VggViewRepresentable: UIViewRepresentable {
        let viewModel: VggViewModel
        
        public init(viewModel: VggViewModel) {
            self.viewModel = viewModel
        }
        
        public func makeUIView(context: Context) -> VggView {
            return viewModel.createVggView()
        }
        
        public func updateUIView(_ view: VggView, context: UIViewRepresentableContext<VggViewRepresentable>) {
        }
        
        public static func dismantleUIView(_ view: VggView, coordinator: Coordinator) {
            if (view == coordinator.viewModel.vggView) {
                coordinator.viewModel.vggView = nil
            }
        }
        
        public func makeCoordinator() -> Coordinator {
            return Coordinator(viewModel: viewModel)
        }
        
        public class Coordinator: NSObject {
            public var viewModel: VggViewModel

            init(viewModel: VggViewModel) {
                self.viewModel = viewModel
            }
        }
    }
#endif
