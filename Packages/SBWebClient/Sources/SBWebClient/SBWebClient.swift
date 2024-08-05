import Foundation

import SBWebClientInterface
import SBCommonModels
import SBNetwork

public enum SBWebClientError: Error {
    case invalidDateRange
}

public final class SBWebClient: SBWebClientInterface {
    public var baseUrl: String
    private var token: String?
    public static let shared: SBWebClient = SBWebClient(baseUrl: Constants.Urls.baseUrl)
    private var network: SBNetwork = SBNetwork()
    
    private init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public func setToken(token: String) {
        self.token = token
        self.network.setToken(token: token)
    }
    
    public func getAccounts() async throws -> [Account] {
        let urlString = Constants.Urls.baseUrl + Constants.ApiVersions.v2 + Constants.UrlPaths.accounts
        let data = try await self.network.get(urlString: urlString)
        let accountResponse: AccountResponse = try JSONDecoder().decode(AccountResponse.self, from: data)
        return accountResponse.accountList
    }
    
    public func getSavingsGoals(accountId: String) async throws -> [SavingsGoal] {
        let urlString = Constants.Urls.baseUrl + Constants.ApiVersions.v2 + Constants.UrlPaths.savingsGoals
        let formattedUrlString = String(format: urlString, accountId)
        let data = try await self.network.get(urlString: formattedUrlString)
        let savingsGoalResponse: SavingsGoalResponse = try JSONDecoder().decode(SavingsGoalResponse.self, from: data)
        return savingsGoalResponse.savingsGoalList
    }
    
    public func getTransactions(accountId: String, categoryId: String, from: Date, to: Date) async throws -> [Transaction] {
        // Ensure that from date is always less than to Date
        guard from < to else { throw SBWebClientError.invalidDateRange }
        
        let urlString = Constants.Urls.baseUrl + Constants.ApiVersions.v2 + Constants.UrlPaths.transactions
        let formattedUrlString = String(format: urlString, accountId,categoryId,from.toISO8601String(),to.toISO8601String())
        let data = try await self.network.get(urlString: formattedUrlString)
        let transactionsResponse: TransactionResponse = try JSONDecoder().decode(TransactionResponse.self, from: data)
        return transactionsResponse.transactionItems
    }
    
    public func createSavingsGoal(accountId: String, savingsGoalName: String, savingsTarget: Int, currency: String) async throws -> CreateSavingsGoalResponse {
        let urlString = Constants.Urls.baseUrl + Constants.ApiVersions.v2 + Constants.UrlPaths.createSavingsGoal
        let formattedUrlString = String(format: urlString, accountId)
        let body: [String:Any] = ["name": savingsGoalName, "currency": currency, "target": ["currency": currency, "minorUnits": savingsTarget], "base64EncodedPhoto": "none"]
        let data = try await self.network.put(urlString: formattedUrlString, body: body)
        let createSavingsGoalResponse: CreateSavingsGoalResponse = try JSONDecoder().decode(CreateSavingsGoalResponse.self, from: data)
        return createSavingsGoalResponse
    }
    
    public func addRoundUpToSavingsGoal(accountId: String, savingsGoalId: String, roundUp: Int, currency: String) async throws -> AddMoneyResponse {
        let urlString = Constants.Urls.baseUrl + Constants.ApiVersions.v2 + Constants.UrlPaths.addMoney
        let formattedUrlString = String(format: urlString, accountId,savingsGoalId,UUID().uuidString.lowercased())
        let body: [String:Any] = ["amount": ["currency": currency, "minorUnits": roundUp]]
        let data = try await self.network.put(urlString: formattedUrlString, body: body)
        let addMoneyResponse: AddMoneyResponse = try JSONDecoder().decode(AddMoneyResponse.self, from: data)
        return addMoneyResponse
    }
}

extension Date {
    func toISO8601String(timeZone: TimeZone? = TimeZone(abbreviation: "UTC")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
}
