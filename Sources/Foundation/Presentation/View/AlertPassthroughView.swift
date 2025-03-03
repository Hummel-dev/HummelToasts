//
//  AlertPassthroughView.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

struct AlertPassthroughView: View {
    @ObservedObject var notificationVM = NotificationViewModel()
    
    var notification: (any Notification)? { notificationVM.notification }
    
    var body: some View {
        if let toast = notification as? (any Toast) {
            AnyView(toast)
                .id(toast.id)
                .frame(
                    maxHeight: .infinity,
                    alignment: Alignment(horizontal: .center, vertical: toast.alignment)
                )
        }
    }
}

#Preview {
    AlertPassthroughView()
}
