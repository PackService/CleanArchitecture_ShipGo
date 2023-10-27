//
//  RemoteCompanyItem.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/02.
//

// MARK: - CompanyModel
struct RemoteCompanyItem: Codable {
    let company: [Company]
    
    enum CodingKeys: String, CodingKey {
        case company = "Company"
    }
}

// MARK: - Company
struct Company: Codable {
    let id: String
    let international: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Code"
        case international = "International"
        case name = "Name"
    }
}

//enum LogoType: String {
//
//    case cj = "04"
//    case cupost = "46"
//    case daesin = "22"
//    case dhl = "13"
//    case ems = "12"
//    case fedex = "21"
//    case gsi = "41"
//    case gspostbox = "24"
//    case hanjin = "05"
//    case hapdong = "32"
//    case ilyana = "11"
//    case koreapost = "01"
//    case kyeongdong = "23"
//    case logen = "06"
//    case lotte = "08"
//    case lxpantos = "37"
//    case nonghyup = "53"
//    case tnt = "25"
//    case ups = "14"
//    case usps = "26"
//    case etc = "998"
//
////    var logo: Logo {
////        switch self {
////        case .cj, .cupost, .daesin, .dhl, .ems, .fedex, .gsi, .gspostbox, .hanjin, .hapdong, .ilyana, .koreapost, .kyeongdong, .logen, .lotte, .lxpantos, .nonghyup, .tnt, .ups, .usps, .etc:
////            return Logo(image: Image("logo_\(self)"), bgColor: Color("bgcolor_\(self)"), fgColor: Color("fgcolor_\(self)"))
////        }
////    }
//}
