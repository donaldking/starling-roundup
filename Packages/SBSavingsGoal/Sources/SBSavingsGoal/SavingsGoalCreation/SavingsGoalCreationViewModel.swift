import Foundation

import SBWebClientInterface
import SBFoundation

enum SavingsGoalCreationViewModelLoadingState {
    case loading
    case completed
    case done
    case error
}

protocol SavingsGoalCreationViewModelDelegate: AnyObject {
    func didCreateSavingsGoal(savingsGoalId: String)
}

protocol SavingsGoalCreationViewModelProtocol: AnyObject {
    init(accountId: String, webClient: any SBWebClientInterface, delegate: (any SavingsGoalCreationViewModelDelegate)?)
    func createSavingsGoal(title: String, targetAmount: String, currency: String)
}

final class SavingsGoalCreationViewModel: SavingsGoalCreationViewModelProtocol {
    private var accountId: String
    private var webClient: any SBWebClientInterface
    private var requestStream: SBDynamicType<SavingsGoalCreationViewModelLoadingState> = .init(value: .done)
    private weak var delegate: (any SavingsGoalCreationViewModelDelegate)?
    
    init(accountId: String, webClient: any SBWebClientInterface, delegate: (any SavingsGoalCreationViewModelDelegate)?) {
        self.accountId = accountId
        self.webClient = webClient
        self.delegate = delegate
    }
        
    func createSavingsGoal(title: String, targetAmount: String, currency: String) {
        self.requestStream.value = .loading
        Task {
            do {
                let response = try await self.webClient.createSavingsGoal(accountId: self.accountId, savingsGoalName: title, savingsTarget: targetAmount.minorUnitsInt ?? 0, currency: currency)
                if response.success == true {
                    DispatchQueue.main.async { [weak self] in
                        print("createSavingsGoal response: \(String(describing: response))")
                        self?.requestStream.value = .completed
                        self?.delegate?.didCreateSavingsGoal(savingsGoalId: response.savingsGoalId ?? "")
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.requestStream.value = .error
                    }
                }

            } catch {
                print("\(#function), \(#line) Error: \(error)")
                DispatchQueue.main.async { [weak self] in
                    self?.requestStream.value = .error
                }
            }
        }
    }
    
    // MARK: - ViewModel to View Binding
    func bindToRequestStream(callback: @escaping ((SavingsGoalCreationViewModelLoadingState) -> Void)) {
        self.requestStream.bind(callback: callback)
    }
}
