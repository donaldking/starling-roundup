public struct AccountResponse: Codable {
    public var accountList: [Account] = []
    
    private enum CodingKeys: String, CodingKey {
        case accountList = "accounts"
    }
    
    public init(accountList: [Account]) {
        self.accountList = accountList
    }
}
