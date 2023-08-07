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
    
//    private let remoteSignUpMapper = remoteSignUpMapper()
    
    func signUp(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never> {
        Future<Result<Void, Error>, Never> { [weak self] promise in
            guard let selfRef = self else { return }
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    promise(.success(.failure(error)))
                    print(error)
                } else {
//                    promise(.success(.success(selfRef.remoteSignUpMapper.remoteItemToBasicEntity(remoteItem: ()))))
                    promise(.success(.success(print("성공"))))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}

//Auth.auth().createUser(withEmail: email, password: password) { result, error  in
//    print("firebaseRegister 결과 :\(String(describing: result))")
//    if let error = error { // 이미 해당 이메일 존재하는 경우
//        print("Error: \(error.localizedDescription)")
//        completion(.failure(NetworkError(code: 1, msg: "파이어베이스 등록 오류여")))
//        return
//    }
//    guard let user = result?.user else { return }
//    let trackInfo = UserInfo(email: email, history: [], trackInfos: nil)
//
//    if error == nil { // 회원가입 완료
////                self.db.collection("users").document(user.uid).setData(["email": user.email, "history": []])
//        completion(.success(result?.user))
//    }
//}
