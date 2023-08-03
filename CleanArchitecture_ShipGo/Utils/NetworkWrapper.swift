//
//  NetworkWrapper.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/13.
//

import Foundation
import Alamofire

struct NetworkWrapper {
    static let shared = NetworkWrapper()
    var apiDomain = ""
    private let jsonDecoder = JSONDecoder()

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
                    completion(.failure(NetworkError(code: json.code, msg: json.msg)))
                } else {
                    completion(.failure(NetworkError(code: error.responseCode, msg: "post basictask fail")))
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
                if let responseData = response.data, let json = try? jsonDecoder.decode(NetworkError.self, from: responseData) {
                    completion(.failure(NetworkError(code: json.code, msg: json.msg)))
                } else {
                    completion(.failure(NetworkError(code: error.responseCode, msg: "get basictask fail")))
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
}
