import Foundation

struct Constants {
    struct ApiVersions {
        private init() {}
        static var v2: String {
            return "/api/v2"
        }
    }
    struct Urls {
        private init() {}
        static var baseUrl: String {
            return "https://api-sandbox.starlingbank.com"
        }
    }
    struct UrlPaths {
        private init() {}
        static var accounts: String {
            return "/accounts"
        }
        static var savingsGoals: String {
            return "/account/%@/savings-goals"
        }
        static var transactions: String {
            return "/feed/account/%@/category/%@/transactions-between?minTransactionTimestamp=%@&maxTransactionTimestamp=%@"
        }
        static var addMoney: String {
            return "/account/%@/savings-goals/%@/add-money/%@"
        }
        static var createSavingsGoal: String {
            return "/account/%@/savings-goals"
        }
    }
}
