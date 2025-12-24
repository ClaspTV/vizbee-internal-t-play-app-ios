//
//  VizbeeInternalTPlayAppApp.swift
//  VizbeeInternalTPlayApp
//
//  Created by Shiva on 10/11/25.
//

import SwiftUI
import VizbeeTPlayKit
import VizbeeKit

@main
struct VizbeeInternalTPlayApp: App {
    
    init() {
        initVizbeeTPlay()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        AppAnalytics.shared.startListening()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func initVizbeeTPlay() {
        let appId = "vzb2379701350"
        var options = VTPOptions()
        options.uiConfiguration = TPlayStyle.darkTheme()
        options.debugMode = true
        VizbeeTPlay.initialize(appId: appId, options: options)
        // Pass the T-Mobile subscriber ID at the earliest possible point in the app lifecycle, whenever it becomes available.”
        Vizbee.addCustomEventAttributes(["TMobile_SubscriberId": "<TMobile_SubscriberId>"])
        print("✅ SDK initialized in App.init()")
    }
}
