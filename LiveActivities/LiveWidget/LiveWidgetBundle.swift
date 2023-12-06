//
//  LiveWidgetBundle.swift
//  LiveWidget
//
//  Created by Ritwik Singh on 02/12/23.
//

import WidgetKit
import SwiftUI

@main
struct LiveWidgetBundle: WidgetBundle {
    var body: some Widget {
        LiveWidget()
        LiveWidgetLiveActivity()
    }
}
