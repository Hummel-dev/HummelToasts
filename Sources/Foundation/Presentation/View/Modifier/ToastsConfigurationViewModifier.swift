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
        self
            .modifier(ToastsConfigurationViewModifier())
    }
}

struct ToastsConfigurationViewModifier: ViewModifier {
    @State var overlayWindow: UIWindow?
    
    @Environment(\.colorScheme) var scheme
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: onCreate)
            .onChange(of: scheme, perform: changeColorScheme(scheme:))
    }
    
    func onCreate() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        guard let windowScene, overlayWindow == nil else { return }
                        
        /// View Controller
        let rootController = UIHostingController(rootView: EmptyView())
        rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
        rootController.view.backgroundColor = .clear
        
        let window = PassthroughWindow(windowScene: windowScene)
        window.backgroundColor = .clear
        window.rootViewController = rootController
        window.isHidden = false
        window.isUserInteractionEnabled = true
        window.tag = 1009
        window.overrideUserInterfaceStyle = .init(scheme)
        window.windowLevel = .alert
        
        overlayWindow = window
    }
    
    func changeColorScheme(scheme: ColorScheme?) {
        guard let overlayWindow else { return }
        
        UIView.transition(with: overlayWindow, duration: 0.3, options: .transitionCrossDissolve) { [weak overlayWindow] in
            overlayWindow?.overrideUserInterfaceStyle = .init(scheme)
        }
    }
}

#Preview {
    Button("Press me") {
        
    }
    .configureToasts()
}
