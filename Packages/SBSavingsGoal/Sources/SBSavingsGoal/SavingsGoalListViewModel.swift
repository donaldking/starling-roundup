import Foundation

import SBWebClientInterface
import SBFoundation

enum SavingsGoalListViewModelLoadingState {
    case loading
    case completed
    case done
    case error
}

protocol SavingsGoalListViewModelProtocol {
    init(coordinator: any SavingsGoalCoordinatorProtocol,
         accountId: String,
         webClient: any SBWebClientInterface,
         savingsGoalsViewModels: [any SavingsGoalViewModelProtocol])
    func loadSavingsGoals(accountId: String)
    func addSavingsGoalViewModel(savingsGoalViewModel: any SavingsGoalViewModelProtocol)
    func numberOfSavingsGoals() -> Int
    func savingsGoalForRow(row: Int) -> (any SavingsGoalViewModelProtocol)?
    func didSelectSavingsGoal(atIndex index: Int)
    func createSavingGoalButtonAction()
}

final class SavingsGoalListViewModel: SavingsGoalListViewModelProtocol {
    private let coordinator: any SavingsGoalCoordinatorProtocol
    private let accountId: String
    private let webClient: any SBWebClientInterface
    private let savingsGoalViewModelDataStream: SBDynamicType<[any SavingsGoalViewModelProtocol]> = .init(value: [])
    private var requestStream: SBDynamicType<SavingsGoalListViewModelLoadingState> = .init(value: .done)
    
    required init(coordinator: any SavingsGoalCoordinatorProtocol,
                  accountId: String,
                  webClient: any SBWebClientInterface,
                  savingsGoalsViewModels: [any SavingsGoalViewModelProtocol])
    {
        self.coordinator = coordinator
        self.accountId = accountId
        self.webClient = webClient
        self.savingsGoalViewModelDataStream.value = savingsGoalsViewModels
    }
    
    func loadSavingsGoals(accountId: String) {
        self.requestStream.value = .loading
        Task {
            do {
                let data = try await webClient.getSavingsGoals(accountId: accountId)
                print("Savings Goals Data received: \(String(describing: data))")
                // Update data on the main thread
                DispatchQueue.main.async { [weak self] in
                    var transformed = data.compactMap({ SavingsGoalViewModel(savingsGoal: $0)})
                    transformed.sort(by: { $0.name < $1.name })
                    self?.savingsGoalViewModelDataStream.value = transformed
                    self?.requestStream.value = .completed
                }
            } catch {
                print("Savings Goals Error: \(error)")
                DispatchQueue.main.async { [weak self] in
                    self?.requestStream.value = .error
                }
            }
        }
    }
    
    func addSavingsGoalViewModel(savingsGoalViewModel: any SavingsGoalViewModelProtocol) {
        self.savingsGoalViewModelDataStream.value.append(savingsGoalViewModel)
    }
    
    func numberOfSavingsGoals() -> Int {
        return savingsGoalViewModelDataStream.value.count
    }
    
    func savingsGoalForRow(row: Int) -> (any SavingsGoalViewModelProtocol)? {
        return savingsGoalViewModelDataStream.value[row]
    }
    
    func didSelectSavingsGoal(atIndex index: Int) {
        let viewModel = self.savingsGoalViewModelDataStream.value[index]
        self.coordinator.goToSavingsGoalDetails(savingsGoalId: viewModel.id, delegate: self)
    }
    
    func createSavingGoalButtonAction() {
        self.coordinator.goToCreateSavingGoalsScreeen(delegate: self)
    }
    
    // MARK: - ViewModel to View Bindings
    func bindToRequestStream(callback: @escaping ((SavingsGoalListViewModelLoadingState) -> Void)) {
        self.requestStream.bind(callback: callback)
    }
}

// MARK: - SavingsGoalDetailsViewModelDelegate
extension SavingsGoalListViewModel: SavingsGoalDetailsViewModelDelegate {
    func didAdd(roundUp minorUnits: Int, savingsGoalId: String) {
        loadSavingsGoals(accountId: self.accountId)
    }
}

// MARK: - SavingsGoalCreationViewModelDelegate
extension SavingsGoalListViewModel: SavingsGoalCreationViewModelDelegate {
    func didCreateSavingsGoal(savingsGoalId: String) {
        loadSavingsGoals(accountId: self.accountId)
    }
}
