//
//  AccountViewModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import Foundation
import Combine

//enum SortState {
//    case loading
//    case latest
//    case highest
//}
//
//final class TransactionMainViewModel {
//    private let useCase: TransactionUseCaseable
//    private var cancelBag = Set<AnyCancellable>()
//    private let sectionModel = CurrentValueSubject<TransactionResponseModel.SummaryTransaction, Never>(.init(summary: .init(fromAmount: "", fee: "", discountFee: ""), transactions: .init(transaction: .init())))
//    private let shouldLoadInitData = CurrentValueSubject<TransactionRequestModel, Never>(.init(lastId: 0))
//    private let sortedState: CurrentValueSubject<SortState, Never> = .init(.loading)
//    private var page: Int = 0
//    private let paginationState: CurrentValueSubject<Bool, Never> = .init(false)
//
//    init(useCase: TransactionUseCaseable) {
//        self.useCase = useCase
//        bind()
//    }
//    private func bind() {
//        shouldLoadInitData
//            .compactMap { [weak self] _ -> TransactionRequestModel? in
//                if let page = self?.page {
//                    return .init(lastId: page)
//                }
//                else {
//                    self?.useCase.sendError( NetworkError(code: 0, msg: "could not create requestModel"))
//                    return nil
//                }
//            }
//            .flatMap(transactions(requestModel:))
//            .combineLatest(useCase.summaryInfo())
//            .sink { [weak self] (transactions, summary) in
//                self?.sectionModel.send(.init(summary: summary, transactions: transactions))
//                self?.paginationState.send(false)
//            }
//            .store(in: &cancelBag)
//    }
//    private func transactions(requestModel: TransactionRequestModel) -> AnyPublisher<TransactionResponseModel.Transaction, Never> {
//        return useCase.transactions(requestModel: requestModel)
//    }
//    func getSectionModelPublisher() -> AnyPublisher<TransactionResponseModel.SummaryTransaction, Never> {
//        return sectionModel.eraseToAnyPublisher()
//    }
//    func didScrollPage() {
//        if paginationState.value == false {
//            paginationState.send(true)
//            print("현재 페이지: \(page)")
//            let requestModel: TransactionRequestModel = TransactionRequestModel(lastId: page)
//            shouldLoadInitData.send(requestModel)
//            page += 5
//        }
//    }
//    func sendSortedStatePublisher(sortState: SortState) {
//        sortedState.send(sortState)
//    }
//    func getSortedStatePublisher() -> AnyPublisher<SortState, Never> {
//        return sortedState.eraseToAnyPublisher()
//    }
//    func getSortedStateValue() -> SortState {
//        sortedState.value
//    }
//    func getErrorPublisher() -> AnyPublisher<Error, Never> {
//        useCase.getErrorSubject()
//    }
//}
