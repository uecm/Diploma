//
//  NotificationManager.swift
//  Diploma
//
//  Created by Egor on 4/4/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UserNotifications

class NotificationManager: NSObject {
    
    let center = UNUserNotificationCenter.current()

    override init() {
        super.init()
        center.delegate = self
    }
    
    
    
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            // Did dismiss push notification
            break
        case UNNotificationDefaultActionIdentifier:
            // Did open push notification
            break
        default: break
        }
    }
}


