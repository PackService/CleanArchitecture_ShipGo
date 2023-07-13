//
//  NetworkWrapper.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/13.
//

import Foundation
import Alamofire

struct MyNetworkWrapper {
    static let shared = MyNetworkWrapper()
    var apiDomain = "https://834536bd-4d2d-42bb-8d70-d028f3bbce11.mock.pstmn.io/"
    private let jsonDecoder = JSONDecoder()

    
    func getBasicTask(stringURL: String, parameters: Parameters? = nil, header: HTTPHeaders? = nil, completion: @escaping (Result<Data, Error>) -> Void ) {
        let defaultHeader = configureHeader()
        
        AF.request("\(apiDomain)\(stringURL)", method: .get, parameters: parameters ,encoding: URLEncoding.queryString, headers: defaultHeader)
            .validate()
            .responseJSON { response in
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
                    completion(.failure(NetworkError(code: error.responseCode, msg: "getAuthTask Fail")))
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
