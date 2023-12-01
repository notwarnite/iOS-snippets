//
//  ContentView.swift
//  LocalNotification
//
//  Created by Ritwik Singh on 01/12/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Local Notification")
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.cyan.gradient.opacity(0.7))
            
            Spacer()
            
            
            Button("Schedule Notification") {
                scheduleNotification()
            }
            .buttonStyle(.borderedProminent)
            Spacer()
            
        }
        .onAppear{
            reqPermission()
        }
    }
    
    func reqPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All OK")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Feed the dog"
        content.subtitle = "It's dinner time"
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
}

#Preview {
    ContentView()
}
