//
//  NotificationModifier.swift
//  HummelToasts
//
//  Created by Archibbald on 3/10/25.
//

import SwiftUI

import Toasts
import ToastsFoundation

public extension View {
    @ViewBuilder
    func notification<Notification: ToastsFoundation.Notification>(
        isPresented: Binding<Bool>,
        notification: Notification
    ) -> some View {
        self
            .modifier(NotificationModifier(isPresented: isPresented, notification: notification))
    }
}

struct NotificationModifier<Notification: ToastsFoundation.Notification>: ViewModifier {
    @Binding var isPresented: Bool
    var notification: Notification
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard isPresented else { return }
                
                HMNotification.custom(notification)
            }
            .onChange(of: isPresented) { newState in
                if newState {
                    HMNotification.custom(notification)
                } else {
                    HMNotification.dismissAll()
                }
            }
            .onReceive(
                NotificationCenter.notification.publisher(for: .didDisappearNotification),
                perform: { _ in
                    isPresented = false
                }
            )
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var isPresented: Bool = false
    
    Button("Press me") {
        isPresented.toggle()
    }
    .notification(
        isPresented: $isPresented,
        notification: Snack {
            SnackRole.failure.icon
                .scaledToFit()
                .frame(width: 25, height: 25)
        } content: {
            Text("Извините. Что-то пошло не так...")
                .font(.subheadline)
        }
    )
    .configureToasts()
}
