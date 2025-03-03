//
//  DismissNotificationAction.swift
//  HummelToasts
//
//  Created by Archibbald on 3/3/25.
//

import Foundation

public struct DismissNotificationAction {
    var dismissCurrent: () -> Void
    
    func callAsFunction() {
        dismissCurrent()
    }
}
