//
//  HMNotification.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

@MainActor
struct HMNotification {
    static func custom<T: Notification>(_ notification: T) {
        NotificationCenter.notification.post(
            name: .willPostNotification,
            object: notification
        )
    }
    
    static func snack(_ content: LocalizedStringKey, role: SnackRole) {
        let snack = Snack {
            role.icon
                .scaledToFit()
                .frame(width: 25, height: 25)
        } content: {
            Text(content)
                .font(.subheadline)
        }

        
        custom(snack)
    }
}
