//
//  AlertPassthroughView.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

struct AlertPassthroughView: View {
    @GestureState var offset: CGFloat = .zero
    
    @ObservedObject var notificationVM = NotificationViewModel()
    
    var notification: (any Notification)? { notificationVM.notification }
    
    var body: some View {
        if let toast = notification as? (any Toast) {
            AnyView(toast)
                .id(toast.id)
                .offset(y: offset)
                .gesture(toast.isControlGesturesActive ? closingGesture(toast: toast) : nil)
                .animation(.default.speed(1.5), value: offset)
                .frame(
                    maxHeight: .infinity,
                    alignment: Alignment(horizontal: .center, vertical: toast.alignment)
                )
        }
    }
    
    func closingGesture(toast: any Toast) -> some Gesture {
        DragGesture()
            .updating($offset) { value, state, transaction in
                if value.location.y < 0 {
                    state = value.location.y
                }
            }
            .onEnded { value in
                guard value.translation.height < 20 else { return }
                
                withAnimation(toast.animation) {
                    notificationVM.notification = nil
                }
            }
    }
}

#Preview {
    AlertPassthroughView()
}
