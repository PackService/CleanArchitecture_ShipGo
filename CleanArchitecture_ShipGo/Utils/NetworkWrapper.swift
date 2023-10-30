//
//  NetworkWrapper.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/13.
//

import Foundation
import Alamofire
import Firebase
import Combine
//import KakaoSDKAuth
//import KakaoSDKUser
import FirebaseFirestoreSwift
//import CryptoKit
import FirebaseAuth
import AuthenticationServices
import FirebaseAnalytics

struct NetworkWrapper {
    
    static let shared = NetworkWrapper()
    var apiDomain = "https://info.sweettracker.co.kr/api/v1/"
    private let jsonDecoder = JSONDecoder()

    let db = Firestore.firestore()
    private var cancelBag = Set<AnyCancellable>()
    
    func postBasicTask(stringURL: String, parameters: Parameters? = nil, header: HTTPHeaders? = nil, completion: @escaping (Result<Data, Error>) -> Void ) {
        var defaultHeader = configureHeader()
        header?.forEach { defaultHeader[$0.name] = $0.value }
        AF.request("\(apiDomain)\(stringURL)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeader).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                if let responseData = response.data {
                    completion(.success(responseData))
                } else {
                    completion(.failure(HTTPError.networkFailureError))
                }
            case .failure(let error):
                if let responseData = response.data, let json = try? jsonDecoder.decode(NetworkError.self, from: responseData) {
                    completion(.failure(NetworkError(statusCode: json.statusCode, message: json.message)))
                } else {
                    completion(.failure(NetworkError(statusCode: error.responseCode, message: "post basictask fail")))
                }
            }
        }
    }
    
    func getBasicTask(stringURL: String, parameters: Parameters? = nil, header: HTTPHeaders? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        var defaultHeader = configureHeader()
        header?.forEach { defaultHeader[$0.name] = $0.value }
        
        AF.request("\(apiDomain)\(stringURL)", method: .get, encoding: JSONEncoding.default, headers: defaultHeader).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                if let responseData = response.data {
                    completion(.success(responseData))
                } else {
                    completion(.failure(HTTPError.networkFailureError))
                }
            case .failure(let error):
                print(error)
                print("\(apiDomain)\(stringURL)")
                if let responseData = response.data, let json = try? jsonDecoder.decode(NetworkError.self, from: responseData) {
                    completion(.failure(NetworkError(statusCode: json.statusCode, message: json.message)))
                } else {
                    completion(.failure(NetworkError(statusCode: error.responseCode, message: "get basictask fail")))
                }
            }
        }
    }
    
    func configureHeader() -> HTTPHeaders {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        manager.session.configuration.timeoutIntervalForResource = 10
        
        let headers: HTTPHeaders = [ "Accept": "application/json" ]
        
        return headers
    }
    
    
    
    // MARK: -위에는 필요없는
}

