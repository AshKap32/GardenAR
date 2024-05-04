//
//  ScanView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 5/3/24.
//

import SwiftUI
import RealityKit
import ARKit

struct PlantsModel: Equatable {
    var name: String
    var fileName: String
}

let plantsModels = [
    PlantsModel(name: "Jacaranda Tree", fileName: "Jacaranda Tree"),
    PlantsModel(name: "Doryopteris Plant", fileName: "Doryopteris Plant"),
    PlantsModel(name: "Philodendron Plant", fileName: "Philodendron Plant"),
    PlantsModel(name: "Zebra Haworthie Plant", fileName: "Zebra Haworthie Plant"),
    
    // Add additional plant models here
]

struct ScanView: View {
    @State private var selectedPlant: PlantsModel? = nil

    var body: some View {
        ZStack {
            ARViewContainer(selectedPlant: $selectedPlant)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(plantsModels, id: \.name) { plant in
                            Button(plant.name) {
                                selectedPlant = plant
                            }
                            .padding()
                            .background(selectedPlant == plant ? Color.green : Color.gray)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        }
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var selectedPlant: PlantsModel?

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        context.coordinator.setupARSession(arView: arView)
        context.coordinator.setupGestures(arView: arView)
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if let plant = selectedPlant {
            context.coordinator.loadModel(plant, in: uiView)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: ARViewContainer
        var models: [ModelEntity] = [] // Track all models

        init(_ parent: ARViewContainer) {
            self.parent = parent
        }

        func setupARSession(arView: ARView) {
            let config = ARWorldTrackingConfiguration()
            config.planeDetection = [.horizontal, .vertical]
            arView.session.run(config)
            arView.debugOptions = [.showFeaturePoints, .showWorldOrigin] // Helps in debugging
        }

       func loadModel(_ plant: PlantsModel, in arView: ARView) {
            arView.scene.anchors.removeAll()
            if let modelEntity = try? ModelEntity.load(named: plant.fileName) {
                let anchorEntity = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
                modelEntity.scale = [0.05, 0.05, 0.05]  // Adjust the scale as needed
                anchorEntity.addChild(modelEntity)
                arView.scene.addAnchor(anchorEntity)
            }
        }


        func setupGestures(arView: ARView) {
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            arView.addGestureRecognizer(panGesture)
        }

        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let arView = gesture.view as? ARView else { return }
            let location = gesture.location(in: arView)
            let results = arView.raycast(from: location, allowing: .existingPlaneGeometry, alignment: .horizontal)

            if let firstResult = results.first, gesture.state == .changed {
                let translation = firstResult.worldTransform.columns.3
                // Move the model that the gesture interacts with
                if let model = models.first(where: { $0.position(relativeTo: nil).distance(to: SIMD3(x: translation.x, y: translation.y, z: translation.z)) < 0.1 }) {
                    model.move(to: firstResult.worldTransform, relativeTo: nil, duration: 0)
                }
            }
        }
    }
}

// Extending SIMD3 to calculate distance
extension SIMD3 where Scalar == Float {
    func distance(to other: SIMD3<Float>) -> Float {
        let dx = self.x - other.x
        let dy = self.y - other.y
        let dz = self.z - other.z
        return sqrt(dx * dx + dy * dy + dz * dz)
    }
}
#Preview {
    NavigationStack {
        ScanView()
    }
}
