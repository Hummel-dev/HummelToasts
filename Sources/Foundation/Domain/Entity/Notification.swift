//
//  Notification.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

public protocol Notification: Identifiable, Sendable, View {
    var id: UUID { get }
}
