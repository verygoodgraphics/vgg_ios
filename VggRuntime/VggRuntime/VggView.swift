//
//  VggView.swift
//  VggRuntime
//
//  Created by houguanhua on 2023/11/16.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

import UIKit

open class VggView: VggRenderView {
    internal weak var vggModel: VggModel?
    
    public init() {
        super.init(frame: .zero)
    }
    
    public convenience init(model: VggModel) {
        self.init()
        vggModel = model
        setModel(model.filePath)
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
