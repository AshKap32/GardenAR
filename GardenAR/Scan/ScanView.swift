//
//  ScanView.swift
//  GardenAR
//
//  Created by Rishi Jagtap on 5/2/24.
//

import Foundation
import SwiftUI

struct ScanView: UIViewRepresentable {
    let scanController = ScanController()

    func makeUIView(context: Context) -> UIView {
        return scanController.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}




#Preview {
    NavigationStack {
        ScanView()
    }
}
