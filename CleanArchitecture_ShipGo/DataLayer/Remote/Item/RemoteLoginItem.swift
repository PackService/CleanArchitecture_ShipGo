//
//  RemoteLoginItem.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//


import Foundation
import FirebaseFirestoreSwift

//MARK: - UserInfo
struct UserInfo: Codable {
    let email: String
    var history: [String]
    var trackInfos: [TrackInfos]?
    
    enum CodingKeys: String, CodingKey {
        case email
        case history
        case trackInfos
    }
    
    var setEmail: [String: Any] {
        return [
            "email": self.email
        ]
    }
    
    var setHistory: [String: Any] {
        return [
            "history": self.history
        ]
    }
    
    var setTrackInfos: [String: Any] {
        return [
            "trackInfos": self.trackInfos ?? []
        ]
    }
}

struct TrackInfos: Codable, Hashable {
    var timeStamp: Date
    var company: String
    var invoice: String
    
    var setInvoice: [String: Any] {
        return [
            "timeStamp": self.timeStamp,
            "company": self.company,
            "invoice": self.invoice
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case timeStamp
        case company
        case invoice
    }
}
