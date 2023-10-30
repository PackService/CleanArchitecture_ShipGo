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
    
//    func getPrices(interval: String, pairId: Int, to: String) -> AnyPublisher<[CoinDetailEntity.Price], Error> {
//        Future<[CoinDetailEntity.Price], Error> { [weak self] promise in
//            guard let selfRef = self else { return }
//            let stringURL = to == "" ? "/market/v1/chart/candles/\(interval)/\(pairId)?&limit=20" : "/market/v1/chart/candles/\(interval)/\(pairId)?to=\(to)&limit=20"
//            NetworkWrapper.shared.getBasicTask(stringURL: stringURL) { result in
//                switch result {
//                case .success(let responseData):
//                    if let data = try? selfRef.jsonDecoder.decode([RemoteCoinDetailtem.Price].self, from: responseData) {
//                        promise(.success((selfRef.remoteCoinDetailMapper.remoteItemsToRemoteItem(remoteItem: data))))
//                        //                        LogDebug(data)
//                    }
//                    promise(.failure(HTTPError.typeMismatchError))
//                    
//                case .failure(let error):
//                    promise(.failure(error))
//                    LogError(error.localizedDescription)
//                }
//            }
//        }.eraseToAnyPublisher()
//    }
    //
    func getRecommendComapny(invoice: String) -> AnyPublisher<Result<[CompanyEntity.Company], Error>, Never> {
        Future<Result<[CompanyEntity.Company], Error>, Never> { [weak self] promise in
            guard let selfRef = self else { return }
            let stringURL = "recommend?t_invoice=\(invoice)&t_key\(Bundle.main.object(forInfoDictionaryKey: "DELIVERY_API_KEY") as? String)"
            NetworkWrapper.shared.getBasicTask(stringURL: stringURL) { [weak self] result in
                switch result {
                case .success(let responseData):
                    if let data = try? selfRef.jsonDecoder.decode(RemoteCompanyItem.self, from: responseData) {
                        promise(.success(.success(selfRef.remoteCompanyMapper.remoteItemToEntity(remoteItem: data))))
                    }
                    // MARK: - 타입 미스매치 에러처리 필요
                case .failure(let error):
                    promise(.success(.failure(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}
    
//    func getDeliveryCompany() -> AnyPublisher<Result<CompanyEntity, Error>, Never> { // MARK: -http 분리, key 값 안전하게 보관할 방법 생각
//        Future<Result<CompanyEntity, Error>, Never> { [weak self] promise in
//            guard let selfRef = self else { return }
//            NetworkWrapper.shared.getBasicTask(stringURL: "https://info.sweettracker.co.kr/api/v1/companylist?t_key=R3piwpbvEXgOCxQFddJEgw") { [weak self] result in
//                switch result {
//                case .success(let jsonResponse):
//                    if let data = try? selfRef.jsonDecoder.decode(RemoteCompanyItem.self, from: jsonResponse) {
//                        promise(.success(.success(selfRef.remoteTransactionMapper.remoteItemsToEntityTransactions(remoteItem: data))))
//                    }
//
//                case .failure(let error):
//                    promise(.success(.failure(error)))
//                }
//            }
//        }
//    }
//}


//func getCompanies() {
//    guard let url = URL(string: "https://info.sweettracker.co.kr/api/v1/companylist?t_key=R3piwpbvEXgOCxQFddJEgw") else { return }
//
//    companySubscription = NetworkingManager.download(url: url)
//        .decode(type: CompanyModel.self, decoder: JSONDecoder())
//        .receive(on: DispatchQueue.main)
//        .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCompanies) in
//            self?.allCompanies = returnedCompanies
//            self?.companySubscription?.cancel()
//        })
//}
