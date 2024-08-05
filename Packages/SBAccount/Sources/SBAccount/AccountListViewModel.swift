import Foundation

import SBWebClientInterface
import SBFoundation

enum AccountListViewModelLoadingState {
    case loading
    case completed
    case done
    case error
}

protocol AccountListViewModelProtocol: AnyObject {
    init(coordinator: any AccountCoordinatorProtocol,
         webClient: any SBWebClientInterface,
         accountViewModels: [any AccountViewModelProtocol])
    func loadAccounts()
    func addAccountViewModel(viewModel: any AccountViewModelProtocol)
    func numberOfAccounts() -> Int
    func accountForRow(row: Int) -> (any AccountViewModelProtocol)?
    func goToTransactions(accountId: String, categoryId: String, timeAgo: SBTimeAgo)
    func goToSavingsGoals(accountId: String, categoryId: String)
}

final class AccountListViewModel: AccountListViewModelProtocol {
    private let coordinator: any AccountCoordinatorProtocol
    private let webClient: any SBWebClientInterface
    private var accountViewModelsDataStream: SBDynamicType<[any AccountViewModelProtocol]> = .init(value: [])
    private var requestStream: SBDynamicType<AccountListViewModelLoadingState> = .init(value: .done)
    
    init(coordinator: any AccountCoordinatorProtocol,
         webClient: any SBWebClientInterface,
         accountViewModels: [any AccountViewModelProtocol])
    {
        self.coordinator = coordinator
        self.webClient = webClient
        self.accountViewModelsDataStream.value = accountViewModels
    }
    
    func loadAccounts() {
        // TODO: Make network request
        // TODO: Update request stream to hold RequestEnum types like - loading, completed
        self.requestStream.value = .loading
        Task {
            do {
                let data = try await webClient.getAccounts()
                print("Account List Data received: \(String(describing: data))")
                // Update data on the main thread
                DispatchQueue.main.async { [weak self] in
                    self?.accountViewModelsDataStream.value = data.compactMap({ AccountViewModel(account: $0)})
                    self?.requestStream.value = .completed
                }
            } catch {
                print("Account List Error: \(error)")
                DispatchQueue.main.async { [weak self] in
                    self?.requestStream.value = .error
                }
            }
        }
    }
    
    func addAccountViewModel(viewModel: any AccountViewModelProtocol) {
        self.accountViewModelsDataStream.value.append(viewModel)
    }
    
    func numberOfAccounts() -> Int {
        return accountViewModelsDataStream.value.count
    }
    
    func accountForRow(row: Int) -> (any AccountViewModelProtocol)? {
        return accountViewModelsDataStream.value[row]
    }
    
    func goToTransactions(accountId: String, categoryId: String, timeAgo: SBTimeAgo) {
        coordinator.goToTransactions(accountId: accountId,
                                      categoryId: categoryId,
                                      timeAgo: timeAgo)
    }
    
    func goToSavingsGoals(accountId: String, categoryId: String) {
        coordinator.goToSavingsGoals(accountId: accountId, categoryId: categoryId)
    }
    
    // MARK: - ViewModel to View Bindings
    func bindToRequestStream(callback: @escaping ((AccountListViewModelLoadingState) -> Void)) {
        self.requestStream.bind(callback: callback)
    }
}
