import Foundation

import SBWebClientInterface
import SBCommonModels

enum MockWebClientError: Error {
    case testError
}

final class MockWebClient: SBWebClientInterface {
    var baseUrl: String
    var mockAccounts: [Account] = []
    var mockSavingsGoal: [SavingsGoal] = []
    var mockTransaction: [Transaction] = []
    var mockCreateSavingsGoalResponse: CreateSavingsGoalResponse!
    var mockAddMoneyResponse: AddMoneyResponse!
    var shouldThrowError = false
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getAccounts() async throws -> [Account] {
        if shouldThrowError {
            throw MockWebClientError.testError
        }
        return self.mockAccounts
    }
    
    func getSavingsGoals(accountId: String) async throws -> [SavingsGoal] {
        if shouldThrowError {
            throw MockWebClientError.testError
        }
        return self.mockSavingsGoal
    }
    
    func getTransactions(accountId: String, categoryId: String, from: Date, to: Date) async throws -> [Transaction] {
        if shouldThrowError {
            throw MockWebClientError.testError
        }
        return self.mockTransaction
    }
    
    func createSavingsGoal(accountId: String, savingsGoalName: String, savingsTarget: Int, currency: String) async throws -> CreateSavingsGoalResponse {
        if shouldThrowError {
            throw MockWebClientError.testError
        }
        return self.mockCreateSavingsGoalResponse
    }
    
    func addRoundUpToSavingsGoal(accountId: String, savingsGoalId: String, roundUp: Int, currency: String) async throws -> AddMoneyResponse {
        if shouldThrowError {
            throw MockWebClientError.testError
        }
        return self.mockAddMoneyResponse
    }
}
