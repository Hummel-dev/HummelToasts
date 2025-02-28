//
//  HMNotification.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

struct HMNotification {
    static func custom<T: Notification>(_ notification: T) {
        NotificationCenter.notification.post(
            name: .willPostNotification,
            object: notification
        )
    }
}
