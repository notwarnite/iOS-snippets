//
//  LiveWidgetLiveActivity.swift
//  LiveWidget
//
//  Created by Ritwik Singh on 02/12/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
            var approximateTime: ClosedRange<Date>
            var delivererName: String
        }
        var activityName: String
}

struct LiveWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TestActivityAttributes.self) { context in
                    HStack {
                        Text(timerInterval: context.state.approximateTime, countsDown: true)
                        Text(context.state.delivererName)
                    }
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text(timerInterval: context.state.approximateTime, countsDown: true)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.delivererName)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("PizzaHub")
                }
            } compactLeading: {
                Text(timerInterval: context.state.approximateTime, countsDown: true)
            } compactTrailing: {
                Text("PizzaHub")
            } minimal: {
                Text("🍕")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LiveWidgetAttributes {
    fileprivate static var preview: LiveWidgetAttributes {
        LiveWidgetAttributes(name: "World")
    }
}

extension LiveWidgetAttributes.ContentState {
    fileprivate static var smiley: LiveWidgetAttributes.ContentState {
        LiveWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: LiveWidgetAttributes.ContentState {
         LiveWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: LiveWidgetAttributes.preview) {
   LiveWidgetLiveActivity()
} contentStates: {
    LiveWidgetAttributes.ContentState.smiley
    LiveWidgetAttributes.ContentState.starEyes
}
