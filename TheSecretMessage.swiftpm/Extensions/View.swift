//
//  File.swift
//  
//
//  Created by Kris on 4/7/23.
//

import SwiftUI

extension View
{
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)

        let format = UIGraphicsImageRendererFormat()
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds,
                                afterScreenUpdates: true)
        }
    }
}

extension View{
    func disableWithOpacity(_ condition: Bool)->some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}
