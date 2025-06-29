//
//  NotificationManager.swift
//  Undo
//
//  Created by Pixel Arabi on 29/06/2025.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func scheduleNotification(for reminder: Reminder) {
        guard reminder.isEnabled else { return }

        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.subtitle = reminder.getHabitName()
        content.sound = .default

        let dateComponents = DateUtils.calendar.dateComponents([.hour, .minute], from: reminder.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: reminder.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    func unscheduleNotification(for reminder: Reminder) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminder.id.uuidString])
    }
}
