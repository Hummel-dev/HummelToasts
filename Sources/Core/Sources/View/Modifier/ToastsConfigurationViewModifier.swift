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
        ZStack {
            self
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            if let windowScene {
                ToastsUIWindowRepresentable(windowScene: windowScene)
                    .ignoresSafeArea()
            }
        }
    }
}

struct ToastsUIWindowRepresentable: UIViewRepresentable {
    var windowScene: UIWindowScene
    
    func makeUIView(context: Context) -> PassthroughWindow {
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
        
        return window
    }
    
    func updateUIView(_ uiView: PassthroughWindow, context: Context) {
        let hostingController = uiView.rootViewController as? UIHostingController<AlertPassthroughView>
        
        guard let hostingController else { return }
        
        var rootView = hostingController.rootView
        rootView.environment = context.environment
        
        hostingController.rootView = rootView
    }
}

#Preview {
    Button("Press me") {
        
    }
    .configureToasts()
}
