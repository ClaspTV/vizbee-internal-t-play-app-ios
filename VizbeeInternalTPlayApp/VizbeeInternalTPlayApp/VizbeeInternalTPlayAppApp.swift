//
//  VizbeeInternalTPlayAppApp.swift
//  VizbeeInternalTPlayApp
//
//  Created by Shiva on 10/11/25.
//

import SwiftUI
import VizbeeTPlayKit

@main
struct VizbeeInternalTPlayApp: App {
    
    init() {
        initVizbeeTPlay()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
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
        print("✅ SDK initialized in App.init()")
    }
}
