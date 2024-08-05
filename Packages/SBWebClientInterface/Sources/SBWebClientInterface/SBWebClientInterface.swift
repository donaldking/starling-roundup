import Foundation

import SBCommonModels

public protocol SBWebClientInterface {
    var baseUrl: String { get set }
    func getAccounts() async throws -> [Account]
    func getSavingsGoals(accountId: String) async throws -> [SavingsGoal]
    func getTransactions(accountId: String, categoryId: String, from: Date, to: Date) async throws -> [Transaction]
    func createSavingsGoal(accountId: String, savingsGoalName: String, savingsTarget: Int, currency: String) async throws -> CreateSavingsGoalResponse
    func addRoundUpToSavingsGoal(accountId: String, savingsGoalId: String, roundUp: Int, currency: String) async throws -> AddMoneyResponse
}
