//
//  HMNotification+Snack.swift
//  HummelToasts
//
//  Created by Archibbald on 3/3/25.
//

import SwiftUI

import Toasts

extension HMNotification {
    public static func snack(_ content: LocalizedStringKey, role: SnackRole) {
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

#Preview("Snack Presentation") {
    Button("Press me") {
        HMNotification.snack("Извините. Что-то пошло не так...", role: .failure)
    }
    .configureToasts()
}
