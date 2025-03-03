//
//  Notification.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

public protocol Notification: Identifiable, Sendable, View {
    var id: UUID { get }
    var animation: Animation { get }
}

public extension Notification {
    var animation: Animation { .default }
}
