//
//  ScanView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 5/2/24.
//
import SwiftUI
import RealityKit
import ARKit

struct PlantsModel: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var fileName: String
}
struct ScanView: View {
    @State private var showingModelPicker = false
    @State private var selectedPlant: PlantsModel?
    @StateObject private var arViewModel = ARViewModel()

   let plantsModels = [
    PlantsModel(name: "Jacaranda Tree", fileName: "Jacaranda Tree"),
    PlantsModel(name: "Doryopteris Plant", fileName: "Doryopteris Plant"),
    PlantsModel(name: "Philodendron Plant", fileName: "Philodendron Plant"),
    PlantsModel(name: "Zebra Haworthie Plant", fileName: "Zebra Haworthie Plant"),
    

]

    var body: some View {
        ZStack {
            ARViewContainer(selectedPlant: $selectedPlant, arViewModel: arViewModel)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        showingModelPicker.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button(action: {
                        arViewModel.removeLastModel()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
            }

            if showingModelPicker {
                ModelPicker(models: plantsModels, showingPicker: $showingModelPicker, selectedModel: $selectedPlant)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(12)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct ModelPicker: View {
    var models: [PlantsModel]
    @Binding var showingPicker: Bool
    @Binding var selectedModel: PlantsModel?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Select a Model")
                .bold()
                .padding()

            ForEach(models) { model in
                Button(action: {
                    selectedModel = model
                    showingPicker = false
                }) {
                    Text(model.name)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }

            Button("Cancel") {
                showingPicker = false
            }
            .foregroundColor(.red)
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding()
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var selectedPlant: PlantsModel?
    @ObservedObject var arViewModel: ARViewModel

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arViewModel.arView = arView // Store the ARView reference
        context.coordinator.setupARSession(arView: arView)
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if let plant = selectedPlant, context.coordinator.lastLoadedModel != plant {
            context.coordinator.loadModel(plant, using: arViewModel)
            context.coordinator.lastLoadedModel = plant
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ARViewContainer
        var lastLoadedModel: PlantsModel?

        init(_ parent: ARViewContainer) {
            self.parent = parent
        }

        func setupARSession(arView: ARView) {
            let config = ARWorldTrackingConfiguration()
            config.planeDetection = [.horizontal, .vertical]
            arView.session.run(config)
            arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
            arView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        }

        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            guard let arView = sender.view as? ARView else { return }
            let location = sender.location(in: arView)
            let results = arView.raycast(from: location, allowing: .existingPlaneGeometry, alignment: .horizontal)

            if let firstResult = results.first {
                if let anchor = firstResult.anchor {
                    arView.session.remove(anchor: anchor)
                }
            }
        }

        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let arView = gesture.view as? ARView else { return }
            let location = gesture.location(in: arView)
            let results = arView.raycast(from: location, allowing: .existingPlaneGeometry, alignment: .horizontal)

            if let firstResult = results.first {
                switch gesture.state {
                case .began, .changed:
                    if let currentAnchor = parent.arViewModel.currentAnchor {
                        currentAnchor.position = simd_make_float3(firstResult.worldTransform.columns.3.x, firstResult.worldTransform.columns.3.y, firstResult.worldTransform.columns.3.z)
                    }
                default:
                    break
                }
            }
        }

        func loadModel(_ plant: PlantsModel, using viewModel: ARViewModel) {
            if let modelEntity = try? ModelEntity.load(named: plant.fileName) {
                let anchorEntity = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
                modelEntity.scale = [0.05, 0.05, 0.05]
                anchorEntity.addChild(modelEntity)
                viewModel.addAnchor(anchorEntity)
            } else {
                print("Could not load model: \(plant.fileName)")
            }
        }
    }
}

class ARViewModel: ObservableObject {
    var arView: ARView?
    private var anchors: [AnchorEntity] = []
    var currentAnchor: AnchorEntity?

    func addAnchor(_ anchor: AnchorEntity) {
        anchors.append(anchor)
        currentAnchor = anchor
        arView?.scene.addAnchor(anchor)
    }

    func removeLastModel() {
        if let lastAnchor = anchors.popLast() {
            arView?.scene.removeAnchor(lastAnchor)
            if let last = anchors.last {
                currentAnchor = last
            } else {
                currentAnchor = nil
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScanView()
    }
}
