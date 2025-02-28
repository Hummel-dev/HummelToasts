//
//  Toast.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

public protocol Toast: Notification {
    var alignment: VerticalAlignment { get }
    var lifetime: TimeInterval { get }
    var isControlGesturesActive: Bool { get }
}

public extension Toast {
    var alignment: VerticalAlignment { .bottom }
    var lifetime: TimeInterval { 2 }
    var isControlGesturesActive: Bool { true }
}
