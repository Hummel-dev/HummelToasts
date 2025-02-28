//
//  PassthroughWindow.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import UIKit

final class PassthroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
        
        return rootViewController?.view == view ? nil : view
    }
}
