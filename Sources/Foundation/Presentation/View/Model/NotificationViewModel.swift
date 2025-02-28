//
//  NotificationViewModel.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import Foundation
import Combine

@MainActor
final class NotificationViewModel: ObservableObject {
    @Published var notification: (any Notification)?
    
    var notificationsHandlerTask: Task<Void, Never>? = nil
    var cancellable: Set<AnyCancellable> = []
    
    init() {
        notificationsHandlerTask = Task {
            let center = NotificationCenter.notification
            let queue = center.notifications(named: .NSBundleResourceRequestLowDiskSpace)
                .compactMap { $0.object as? (any Notification) }
            
            for await notification in queue {
                self.notification = notification
            }
        }
        
        $notification
            .dropFirst()
            .compactMap { $0 as? (any Toast) }
            .removeDuplicates(by: { $0.id == $1.id })
            .sink { [weak self] toast in
                DispatchQueue.main.asyncAfter(deadline: .now() + toast.lifetime) { [weak self] in
                    self?.notification = nil
                }
            }
            .store(in: &cancellable)
    }
}
