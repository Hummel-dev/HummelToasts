//
//  NotificationViewModel.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import Combine
import SwiftUI

@MainActor
final class NotificationViewModel: ObservableObject {
    @Published var notification: (any Notification)?
    
    var notificationsHandlerTask: Task<Void, Never>? = nil
    var notificationCancelationTask: Task<Void, Error>? = nil
    var cancellable: Set<AnyCancellable> = []
    
    init() {
        notificationsHandlerTask = Task {
            let center = NotificationCenter.notification
            let queue = center.notifications(named: .willPostNotification)
                .compactMap { $0.object as? (any Notification) }
            
            for await notification in queue {
                withAnimation(notification.animation) {
                    self.notification = notification
                }
            }
        }
        
        $notification
            .dropFirst()
            .compactMap { $0 as? (any Toast) }
            .removeDuplicates(by: { $0.id == $1.id })
            .sink { [weak self] toast in
                self?.notificationCancelationTask?.cancel()
                self?.notificationCancelationTask = Task {
                    let nanoseconds = UInt64(toast.lifetime) * 1_000_000_000
                    
                    try await Task.sleep(nanoseconds: nanoseconds)
                    
                    withAnimation(toast.animation) {
                        self?.notification = nil
                    }
                }
            }
            .store(in: &cancellable)
    }    
}
