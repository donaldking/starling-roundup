import UIKit

import SBFoundation
import SBWebClientInterface

enum SavingsGoalDetailsViewModelLoadingState {
    case loading
    case completed
    case done
    case error
}

protocol SavingsGoalDetailsViewModelProtocol {
    init(coordinator: any SavingsGoalCoordinatorProtocol,
         accountId: String,
         categoryId: String,
         savingsGoalId: String,
         delegate: (any SavingsGoalDetailsViewModelDelegate)?,
         webClient: any SBWebClientInterface)
    var accountId: String { get }
    var categoryId: String { get }
    var savingsGoalId: String { get }
    func fetchRoundUpAmountFromSpendings(since timeAgo: SBTimeAgo)
    func addMoneyToSavingsGoal(roundUpAmount: Int, currency: String)
}

protocol SavingsGoalDetailsViewModelDelegate: AnyObject {
    func didAdd(roundUp minorUnits: Int, savingsGoalId: String)
}

final class SavingsGoalDetailsViewModel: SavingsGoalDetailsViewModelProtocol {
    var accountId: String
    var categoryId: String
    var savingsGoalId: String
    weak var delegate: (any SavingsGoalDetailsViewModelDelegate)?
    private let coordinator: any SavingsGoalCoordinatorProtocol
    private let webClient: any SBWebClientInterface
    private var requestStream: SBDynamicType<SavingsGoalDetailsViewModelLoadingState> = SBDynamicType(value: .done)
    private var roundUpAmountStream: SBDynamicType<(rawValue: Int, displayValue: String?)> = SBDynamicType(value: (0, "0"))
    
    init(coordinator: any SavingsGoalCoordinatorProtocol,
         accountId: String,
         categoryId: String,
         savingsGoalId: String,
         delegate: (any SavingsGoalDetailsViewModelDelegate)?,
         webClient: any SBWebClientInterface)
    {
        self.coordinator = coordinator
        self.accountId = accountId
        self.categoryId = categoryId
        self.savingsGoalId = savingsGoalId
        self.delegate = delegate
        self.webClient = webClient
    }
    
    func fetchRoundUpAmountFromSpendings(since timeAgo: SBTimeAgo) {
        self.requestStream.value = .loading
        Task {
            do {
                let transactions = try await self.webClient.getTransactions(accountId: self.accountId,
                                                                             categoryId: self.categoryId,
                                                                             from: timeAgo.dateRange.minDate,
                                                                             to: timeAgo.dateRange.maxDate)
                let roundUpAmount = transactions.reduce(0, { partialResult, transaction in
                    return partialResult + transaction.roundUpAmountInMinorUnits()
                })
                let roundUpAmountInfo = (roundUpAmount, roundUpAmount.floatValue.moneyFormat("GBP"))
                DispatchQueue.main.async { [weak self] in
                    self?.roundUpAmountStream.value = roundUpAmountInfo
                    self?.requestStream.value = .completed
                }
            } catch {
                print("fetchRoundUpAmountFromSpendings Error: \(error)")
                DispatchQueue.main.async { [weak self] in
                    self?.requestStream.value = .error
                }
            }
        }
    }
    
    func addMoneyToSavingsGoal(roundUpAmount: Int, currency: String) {
        self.requestStream.value = .loading
        Task {
            do {
                let response = try await self.webClient.addRoundUpToSavingsGoal(accountId: self.accountId,
                                                                      savingsGoalId: self.savingsGoalId,
                                                                      roundUp: roundUpAmount,
                                                                      currency: currency)
                if response.success == true {
                    DispatchQueue.main.async { [weak self] in
                        self?.requestStream.value = .completed
                        // Notify receiver that savings goal amount has been updated
                        self?.delegate?.didAdd(roundUp: roundUpAmount, savingsGoalId: self?.savingsGoalId ?? "")
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.requestStream.value = .error
                    }
                }

            } catch {
                print("Error: \(error)")
                DispatchQueue.main.async { [weak self] in
                    self?.requestStream.value = .error
                }
            }
        }
    }
    // MARK: - ViewModel to View Bindings
    func bindToRequestStream(callback: @escaping ((SavingsGoalDetailsViewModelLoadingState) -> Void)) {
        self.requestStream.bind(callback: callback)
    }
    
    func bindToRoundUpAmountStream(callback: @escaping (((Int, String?)) -> Void)) {
        self.roundUpAmountStream.bind(callback: callback)
    }
    
    deinit {
        print("SavingsGoalDetailsViewModel deinit")
    }
}


// MARK: - Extensions to move
extension Int {
    var floatValue: Float {
        return Float(self) / 100.0
    }
}

extension Float {
    func moneyFormat(_ currencyCode: String = "GBP") -> String {
        return self.formatted(.currency(code: currencyCode))
    }
}

extension String {
    var minorUnitsInt: Int? {
        if let value = Float(self) {
            let floatValue = Float(value * 100)
            return Int(floatValue)
        } else { return nil }
    }
}
