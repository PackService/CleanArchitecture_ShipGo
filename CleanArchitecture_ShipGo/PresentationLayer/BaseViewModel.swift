//
//  BaseViewModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import Foundation
import Combine

class BaseViewModel {
    var errorSubject = PassthroughSubject<Error, Never>()
}
