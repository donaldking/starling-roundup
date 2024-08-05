import Foundation

import SBWebClientInterface
import SBFoundation

enum TransactionListViewModelLoadingState {
    case loading
    case completed
    case done
    case error
}

protocol TransactionListViewModelProtocol {
    init(coordinator: any TransactionCoordinatorProtocol,
         webClient: any SBWebClientInterface,
         accountId: String,
         categoryId: String,
         timeAgo: SBTimeAgo)
    func loadTransactions(accountId: String, categoryId: String, timeAgo: SBTimeAgo)
}

final class TransactionsListViewModel: TransactionListViewModelProtocol {
    private let coordinator: any TransactionCoordinatorProtocol
    private let webClient: any SBWebClientInterface
    private let accountId: String
    private let categoryId: String
    private let timeAgo: SBTimeAgo
    private var transactionsDataStream: SBDynamicType<[any TransactionViewModelProtocol]> = .init(value: [])
    private var requestStream: SBDynamicType<TransactionListViewModelLoadingState> = .init(value: .done)
    
    init(coordinator: any TransactionCoordinatorProtocol,
         webClient: any SBWebClientInterface,
         accountId: String,
         categoryId: String,
         timeAgo: SBTimeAgo) {
        self.coordinator = coordinator
        self.webClient = webClient
        self.accountId = accountId
        self.categoryId = categoryId
        self.timeAgo = timeAgo
        
        // TODO: Remove this from init
        self.loadTransactions(accountId: accountId, categoryId: categoryId, timeAgo: timeAgo)
    }
    
    func loadTransactions(accountId: String, categoryId: String, timeAgo: SBTimeAgo) {
        let fromDate = timeAgo.dateRange.minDate
        let toDate = timeAgo.dateRange.maxDate
        Task {
            do {
                let data = try await webClient.getTransactions(accountId: accountId,
                                                                categoryId: categoryId,
                                                                from: fromDate,
                                                                to: toDate)
                print("TransactionResponse Data received: \(String(describing: data))")
                // Update data on the main thread
                DispatchQueue.main.async {
                    data.forEach({self.transactionsDataStream.value.append(TransactionViewModel(transaction: $0))})
                    self.requestStream.value = .completed
                }
            } catch {
                print("Transactions Error: \(error)")
                self.requestStream.value = .error
            }
        }
    }
}
