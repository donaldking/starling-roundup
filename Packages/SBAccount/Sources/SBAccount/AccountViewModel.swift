import SBCommonModels

protocol AccountViewModelProtocol {
    init(account: Account)
    var id: String { get }
    var type: String { get }
    var name: String { get }
    var defaultCatgoryId: String { get }
    var currency: String { get }
    var createdAt: String { get }
}

final class AccountViewModel: AccountViewModelProtocol {
    private var account: Account
    var id: String {
        return self.account.id ?? ""
    }
    var type: String {
        return self.account.type ?? ""
    }
    var name: String {
        return self.account.name ?? ""
    }
    var defaultCatgoryId: String {
        return self.account.defaultCategoryId ?? ""
    }
    var currency: String {
        return self.account.currency ?? ""
    }
    var createdAt: String {
        return self.account.createdAt ?? ""
    }
    
    init(account: Account) {
        self.account = account
    }
}
