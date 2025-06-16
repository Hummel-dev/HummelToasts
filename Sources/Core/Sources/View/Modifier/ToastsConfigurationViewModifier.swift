//
//  ToastsConfigurationViewModifier.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func configureToasts() -> some View {
        background {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            if let windowScene {
                ToastsUIWindowRepresentable(windowScene: windowScene)
            }
        }
    }
}

struct ToastsUIWindowRepresentable: UIViewRepresentable {
    var windowScene: UIWindowScene
    
    func makeUIView(context: Context) -> UIView {
        let environment = context.environment
        let rootView = AlertPassthroughView(environment: environment)
        
        let rootController = UIHostingController(rootView: rootView)
        rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
        rootController.view.backgroundColor = .clear
        
        let window = PassthroughWindow(windowScene: windowScene)
        window.tag = 1009
        window.isHidden = false
        window.windowLevel = .alert
        window.backgroundColor = .clear
        window.rootViewController = rootController
        window.isUserInteractionEnabled = true
        window.overrideUserInterfaceStyle = .init(context.environment.colorScheme)
        
        context.coordinator.window = window
        
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        let window = context.coordinator.window
        
        guard let window else { return }
        
        let hostingController = window.rootViewController as? UIHostingController<AlertPassthroughView>
        
        guard let hostingController else { return }
        
        var rootView = hostingController.rootView
        rootView.environment = context.environment
        
        hostingController.rootView = rootView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator {
        var window: PassthroughWindow?
    }
}

#Preview {
    Button("Press me") {
        
    }
    .configureToasts()
}
