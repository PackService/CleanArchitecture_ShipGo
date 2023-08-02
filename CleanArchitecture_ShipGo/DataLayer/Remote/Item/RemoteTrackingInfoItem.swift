//
//  RemoteTrackingInfoItem.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/02.
//

import Foundation

struct TrackingInfoModel: Codable, Identifiable {
    let id = UUID().uuidString
    let complete: Bool?
    let level: Int?
    var invoiceNo: String?
    let isValidInvoice: String?
    let itemImage, itemName: String?
    let receiverAddr, receiverName, recipient: String?
    let senderName: String?
    let trackingDetails: [TrackingDetailsModel]?
    let estimate: String?
    let productInfo: String?
    var company: String? = nil
    let status: Bool?
    let msg: String?
    let code: String?
    var addedTime: Date?
    
    enum CodingKeys: String, CodingKey {
        case complete
        case level
        case invoiceNo
        case itemImage, itemName
        case receiverAddr, receiverName, recipient
        case senderName
        case trackingDetails
        case estimate
        case productInfo
        case isValidInvoice = "result"
        case status
        case msg
        case code
        case addedTime
    }
    
    var currentStep: Double {
        guard let details = self.trackingDetails, !details.isEmpty else { return 0 }
        
        var current = -1
        var result = 0.0
        
        for detail in details {
            current = max(detail.level, current)
        }
        
        if 0 <= current && current <= 4 {
            result = 1
        } else if current == 5 {
            result = 2
        } else {
            result = 3
        }
        
        return result
    }
    
}

struct TrackingDetailsModel: Identifiable, Codable {
    let id = UUID().uuidString
    let kind: String
    let level: Int
    let manName, telno, telno2: String
    let timeString, detailWhere: String
    
    enum CodingKeys: String, CodingKey {
        case kind
        case level
        case manName, telno, telno2
        case timeString
        case detailWhere = "where"
    }
    
    var timeAndDateTuple: (date: String, time: String) {
        var timeArr = self.timeString.split(separator: " ").map { String($0) }
        var date = timeArr[0].replacingOccurrences(of: "-", with: ".")
        var time = String(timeArr[1].dropLast(3))
        
        return (date: date, time: time)
    }
    
}
