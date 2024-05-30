//
//  Root.swift
//  VggExample
//
//  Created by houguanhua on 2023/12/7.
//  Copyright © 2023 VeryGoodGraphics LTD. All rights reserved.
//

import SwiftUI

struct Root: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Counter with code in swift") { VggCounter() }
                NavigationLink("Counter with code in js") { VggJsCounter() }
                NavigationLink("Prototype interactions") { VggJsExample() }
            }
            .navigationTitle("Vgg Examples")
        }
    }
}

