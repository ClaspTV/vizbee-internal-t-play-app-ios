//
// TPlayStyle.swift
// VizbeeKit
//
// Copyright © Vizbee. All rights reserved.
//

import Foundation
import UIKit
import VizbeeKit

class TPlayStyle: NSObject {
  static func getUIStyle(style: UIUserInterfaceStyle) -> [String: Any] {
    darkTheme()
  }
  
  
  // MARK: - Dark Theme
  
    static func darkTheme() -> [String: Any] {
        return [
            
            "base": "DarkTheme",
            
            "references": [
                "@primaryFont": "ProductSans-Bold",
                "@secondaryFont": "ProductSans-Regular",
                
                // Input colors
                "@primaryColor": "#1A1A1A",       // background & border color
                "@secondaryColor": "#E20074",     // highlights or accent color
                "@tertiaryColor": "#FFFFFF",      // content or text color
                
                "@lighterPrimaryColor": "#4A4A4A",
                "@lighterTertiaryColor": "#A0A0A0",
                
                // Constant colors
                "@clearColor": [
                    "effect": "transparency",
                    "percent": 0.0
                ],
                
                // Derived colors
                "@disabledButtonColor": [
                    "effect": "darken",
                    "percent": 0.4,
                    "baseColor": "@tertiaryColor"
                ],
                
                // Font references
                "@headerLabel": [
                    "font": [
                        "family": "@primaryFont",
                        "size": 24,
                        "weight": "bold"
                    ],
                    "textTransform": NSNull(),
                    "textColor": "@tertiaryColor"
                ],
                "@titleLabel": [
                    "font": [
                        "family": "@primaryFont",
                        "size": 14,
                        "weight": "bold",
                        "style" : "title2"
                    ],
                    "textTransform": NSNull(),
                    "textColor": "@tertiaryColor"
                ],
                "@subtitleLabel": [
                    "font": [
                        "family": "@secondaryFont",
                        "size": 12,
                        "weight": "regular"
                    ],
                    "textTransform": NSNull(),
                    "textColor": "@tertiaryColor"
                ],
                "@instructionLabel": [
                    "font": [
                        "family": "@secondaryFont",
                        "size": 12,
                        "weight": "regular"
                    ],
                    "textTransform": NSNull(),
                    "textColor": "@lighterTertiaryColor"
                ],
                "@sentenceTitleLabel": [
                    "font": [
                        "family": "@primaryFont",
                        "size": 17,
                        "weight": "semibold"
                    ],
                    "textTransform": NSNull(),
                    "textColor": "@tertiaryColor"
                ],
                "@actionTitleLabel": [
                    "font": [
                        "family": "@primaryFont",
                        "size": 17,
                        "weight": "semibold",
                        "style" : "headline"
                    ],
                    "textTransform": NSNull(),
                    "textColor": "@tertiaryColor"
                ],
                "@actionBodyText": [
                    "font": [
                        "family": "@secondaryFont",
                        "size": 15,
                        "weight": "regular",
                        "style" : "subheadline"
                    ],
                    "textTransform": NSNull(),
                    "textColor": "@tertiaryColor"
                ]
            ],
            
            "classes": [
                
                "CastIcon" : [
                    "unavailableColor" : "@lighterPrimaryColor",
                    "disconnectedColor" : NSNull(),
                    "connectedColor"  : NSNull(),
                    
                    "notConnectedImageName" : "castIcon_notConnected",
                    "connecting0ImageName"  : "castIcon_connecting0",
                    "connecting1ImageName"  : "castIcon_connecting1",
                    "connecting2ImageName"  : "castIcon_connecting2",
                    "connectedImageName"    : "castIcon_connected",
                ],
                
                "BackgroundLayer": [
                    "backgroundType"  : "color",
                    "backgroundColor" : "@primaryColor",
                ],
                
                //----------------------------
                // Labels & text
                //----------------------------
                
                "UILabel" : [
                    "font" : [
                        "name" : "@primaryFont",
                        "style": "body"
                    ],
                    "textColor" : "@tertiaryColor"
                ],
                
                "HeaderLabel" : "@headerLabel",
                "TitleLabel" : "@titleLabel",
                "SubtitleLabel" : "@subtitleLabel",
                "SentenceTitleLabel" : "@sentenceTitleLabel",
                "InstructionLabel" : "@instructionLabel",
                "ActionTitleLabel" : "@actionTitleLabel",
                "ActionBodyText"   : "@actionBodyText",
                
                "DeviceNameLabel" : [
                    "font": [
                        "family": "@primaryFont",
                        "size": 14,
                        "weight": "regular"
                    ],
                    "textTransform": NSNull(),
                    "textColor": "@tertiaryColor"
                ],
                
                "OrLabel" : [
                    "font": [
                        "family": "@primaryFont",
                        "size": 14,
                        "weight": "regular"
                    ],
                    "textColor" : "@lighterTertiaryColor"
                ],
                "OrDevider" : [
                    "backgroundColor" : "@lighterPrimaryColor",
                ],
                "DeviceView" : [
                    "backgroundColor" : "@lighterPrimaryColor",
                    "cornerRadius"    : 26,
                ],
                "DisabledDeviceView" : [
                    "backgroundColor" : "@lighterPrimaryColor",
                    "cornerRadius"    : 26,
                    "alpha"           : 0.7
                ],
                "DevicesContainerView" : [
                    "borderWidth"     : 1,
                    "borderColor"     : "@secondaryColor"
                ],
                "NoDevicesContainerView" : [
                    "borderWidth"     : 1,
                    "borderColor"     : "@secondaryColor"
                ],
                
                // Vizbee SDK
                
                
                "DeviceStatusSpinner" : [
                    "size":42,
                    "style" : "arc",  // one of classic, vizbee, or arc
                    "lineWidth" : 2,
                ],
                
                //---
                // Device Selection & Device Status Views Title Styling
                //---
               
             "DeviceStatusView.DeviceStatusLabel": [
                   "textTransform": nil,
                   "font": [
                        "name": "@primaryFont",
                       "style": "title2"
                   ]
               ],
                "DeviceInfoView.DeviceNameLabel": [
                    "textTransform": nil,
                    "font": [
                        "name": "@secondaryFont",
                        "style": "body"
                    ]
                ],
                
                "CallToActionButton" : [
                    "cornerRadius" : 31,
                    "font" : [
                        "name" : "@primaryFont",
                        "style": "body"
                    ],
                    "textTransform": NSNull(),
                    "backgroundColor" : "@secondaryColor",
                    "margin" : [20.0, 72.0, 20.0, 72.0],
                    "showsTouchWhenHighlighted" : true
                ],
                
                "OverlayCallToActionButton" : [
                    "cornerRadius" : 31,
                    "font" : [
                        "name" : "@primaryFont",
                        "style": "body"
                    ],
                    "textTransform": NSNull(),
                    "backgroundColor" : "@secondaryColor",
                    "margin" : [20.0, 72.0, 20.0, 72.0],
                    "showsTouchWhenHighlighted" : true
                ],
                
                "UISlider" : [
                    "useCircleThumbControl" : true,
                    "circleThumbDiameter" : 16,
                ],
                
                "PlayerCard.TitledImageView": [
                    "margin" : [48, 0, 0, 0],
                ],
                "PlayerCard.TitledImageView.Image": [
                    "margin" : [48, 0, 0, 0],
                    "cornerRadius": 16
                ],
                "PlayerCard.PlaybackControls.DeviceInfoView" : [
                    "iconStyle" : "real",
                ],
                "PlaybackControls.DeviceInfoView.DeviceIcon" : [
                    "filterEffect" : "none",
                ],
                "PlaybackControls" : [
                    "buttonSize" : 48,
                    "playPauseButtonSize" : 72,
                ],
                "PlaybackControls.PlayPauseButton.ControlButton" : [
                    "cornerRadius" : 36,
                ],
                
                "UnextendedPlayerCard.TitledImageView": [
                    "margin" : [48, 0, 0, 0],
                ],
                "UnextendedPlayerCard.TitledImageView.Image": [
                    "margin" : [48, 0, 0, 0],
                    "cornerRadius": 16
                ],
            ],
            
            "ids": [
                "PlayerCard.videoStatus.contentStatusView": [
                    "backgroundColor": [
                        "effect": "transparency",
                        "percent": 0.6,
                        "baseColor": "@primaryColor"
                    ]
                ],
                "PlayerCard.videoStatus.adStatusView": [
                    "backgroundColor": [
                        "effect": "transparency",
                        "percent": 0.6,
                        "baseColor": "@primaryColor"
                    ]
                ],
            ]
        ]
    }
    
    @objc
    static let lightTheme: [String: Any] = [
      "base": "LightTheme",
      
      // Level 1
      "references": [
        "@primaryFont"        : "PlexCircular-Bold",
        "@secondaryFont"      : "InterDisplay-Regular",
        
        "@primaryColor": "#000000",
        "@secondaryColor": "#E5A00D",
        "@tertiaryColor": "#FFFFFF",
      ],
      // Level 2
      "ids": [
          
      ],
      // Level 3
      "classes": [
          
      ]
    ]
}

