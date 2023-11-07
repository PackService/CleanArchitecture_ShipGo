//
//  RemoteDataSourceImpl.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation
import Combine
import Alamofire
import FirebaseAuth

class RemoteDataSourceImpl: RemoteDataSourceable {
    private let jsonDecoder = JSONDecoder()
    private let remoteCompanyMapper = RemoteCompanyMapper()
    
    func signUp(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never> {
        Future<Result<Void, Error>, Never> { [weak self] promise in
            guard let selfRef = self else { return }
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                if let error = error {
                    promise(.success(.failure(error)))
                    print(error)
                } else {
                    UserDefaultsUtil.shared.setIsLogin(email: email)
                    promise(.success(.success(print("성공"))))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never> {
        Future<Result<Void, Error>, Never> { [weak self] promise in
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                if let error = error {
                    promise(.success(.failure(error)))
                    print("remoteImpl login error :\(error)")
                } else {
                    UserDefaultsUtil.shared.setIsLogin(email: email)
                    promise(.success(.success(print("성공"))))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getRecommendCompany(invoice: String) -> AnyPublisher<Result<[CompanyEntity.Company], Error>, Never> {
        Future<Result<[CompanyEntity.Company], Error>, Never> { [weak self] promise in
            guard let selfRef = self else { return }
            let stringURL = "recommend?t_invoice=\(invoice)&t_key\(Bundle.main.object(forInfoDictionaryKey: "DELIVERY_API_KEY") as? String)"
            NetworkWrapper.shared.getBasicTask(stringURL: stringURL) { [weak self] result in
                switch result {
                case .success(let responseData):
                    if let data = try? selfRef.jsonDecoder.decode(RemoteCompanyItem.self, from: responseData) {
                        promise(.success(.success(selfRef.remoteCompanyMapper.remoteItemToEntity(remoteItem: data))))
                    }
                    print("recommend 타입 미스매치")
                case .failure(let error):
                    promise(.success(.failure(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getAllCompany() -> AnyPublisher<Result<[CompanyEntity.Company], Error>, Never> {
        Future<Result<[CompanyEntity.Company], Error>, Never> { [weak self] promise in
            guard let selfRef = self else { return }
            let stringURL = "companylist?t_key=\(Bundle.main.object(forInfoDictionaryKey: "DELIVERY_API_KEY") as! String)"
            NetworkWrapper.shared.getBasicTask(stringURL: stringURL) { [weak self] result in
                switch result {
                case .success(let responseData):
                    if let data = try? selfRef.jsonDecoder.decode(RemoteCompanyItem.self, from: responseData) {
                        promise(.success(.success(selfRef.remoteCompanyMapper.remoteItemToEntity(remoteItem: data))))
                    }
                    // MARK: - 타입 미스매치 에러처리 필요
                case .failure(let error):
                    print(error)
                    promise(.success(.failure(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}
    
