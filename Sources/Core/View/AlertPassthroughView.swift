//
//  AlertPassthroughView.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

import ToastsFoundation
import Toasts

struct AlertPassthroughView: View {
    typealias Notification = ToastsFoundation.Notification
    
    @State var offset: CGFloat = .zero
    
    @ObservedObject var notificationVM = NotificationViewModel()
    
    var notification: (any Notification)? { notificationVM.notification }
    
    var body: some View {
        if let toast = notification as? (any Toast) {
            AnyView(toast)
                .id(toast.id)
                .offset(y: offset)
                .gesture(toast.isControlGesturesActive ? closingGesture(toast: toast) : nil)
                .frame(
                    maxHeight: .infinity,
                    alignment: Alignment(horizontal: .center, vertical: toast.alignment)
                )
                .environment(
                    \.dismissNotification,
                     DismissNotificationAction(
                        dismissCurrent: { [weak notificationVM] in
                            withAnimation(toast.animation) {
                                notificationVM?.notification = nil
                            }
                        }
                     )
                )
                .onAppear {
                    offset = .zero
                }
        }
    }
    
    func closingGesture(toast: any Toast) -> some Gesture {
        DragGesture(minimumDistance: 20)
            .onChanged { value in
                if value.location.y < 0 {
                    offset = value.location.y
                }
            }
            .onEnded { value in
                withAnimation(toast.animation) {
                    notificationVM.notification = nil
                }
            }
    }
}

#Preview {
    AlertPassthroughView()
}
