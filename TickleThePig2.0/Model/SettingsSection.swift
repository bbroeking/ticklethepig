//
//  SettingsSection.swift
//  TickleThePig2.0
//
//  Created by Brian Broeking on 12/31/19.
//  Copyright © 2019 Brian Broeking. All rights reserved.
//

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Social
//    case Communications
    
    var description: String {
        return "Social"
//        switch self {
//        case .Social: return "Social"
//        case .Communications: return "Communications"
//        }
    }
}

enum SocialOptions: Int, CaseIterable, CustomStringConvertible {
    case logout
    
    var description: String {
        switch self {
        case .logout: return "Logout"
        }
    }
}

//enum CommunicationsOptions: Int, CaseIterable, CustomStringConvertible {
//    case notifications
//    case email
//    case reportCrashes
//
//    var description: String {
//        switch self {
//        case .notifications: return "Notifications"
//        case .email: return "Email"
//        case .reportCrashes: return "Report Crashes"
//
//        }
//    }
//}

