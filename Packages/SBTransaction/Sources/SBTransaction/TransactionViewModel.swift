import SBCommonModels

protocol TransactionViewModelProtocol {
    init(transaction: Transaction)
    var id: String { get }
    var categoryId: String { get }
    var amount: (any AmountViewModelProtocol)? { get }
    var sourceAmount: (any SourceAmountProtocol)? { get }
    var direction: String { get }
    var updatedAt: String { get }
    var transactionTime: String { get }
    var settlementTime: String { get }
    var source: String { get }
    var status: String { get }
    var transactingApplicationUserUid: String { get }
    var counterPartyType: String { get }
    var counterPartyUid: String { get }
    var counterPartyName: String { get }
    var country: String { get }
    var spendingCategory: String { get }
    var hasAttachment: Bool { get }
    var hasReceipt: Bool { get }
}

protocol SourceAmountProtocol {
    var currency: String { get }
    var minorUnits: Int { get }
}

protocol AmountViewModelProtocol {
    var currency: String { get }
    var minorUnits: Int { get }
}

final class TransactionViewModel: TransactionViewModelProtocol {
    private var transaction: Transaction
    var id: String {
        return transaction.id ?? ""
    }
    var categoryId: String {
        return transaction.categoryId ?? ""
    }
    var amount: (any AmountViewModelProtocol)? {
        return transaction.amount as? AmountViewModelProtocol
    }
    var sourceAmount: (any SourceAmountProtocol)? {
        return transaction.sourceAmount as? SourceAmountProtocol
    }
    var direction: String {
        return transaction.direction ?? ""
    }
    var updatedAt: String {
        return transaction.updatedAt ?? ""
    }
    var transactionTime: String {
        return transaction.transactionTime ?? ""
    }
    var settlementTime: String {
        return transaction.settlementTime ?? ""
    }
    var source: String {
        return transaction.source ?? ""
    }
    var status: String {
        return transaction.status ?? ""
    }
    var transactingApplicationUserUid: String {
        return transaction.transactingApplicationUserUid ?? ""
    }
    var counterPartyType: String {
        return transaction.counterPartyType ?? ""
    }
    var counterPartyUid: String {
        return transaction.counterPartyUid ?? ""
    }
    var counterPartyName: String {
        return transaction.counterPartyName ?? ""
    }
    var country: String {
        return transaction.country ?? ""
    }
    var spendingCategory: String {
        return self.transaction.spendingCategory ?? ""
    }
    var hasAttachment: Bool {
        return self.transaction.hasAttachment
    }
    var hasReceipt: Bool {
        return self.transaction.hasReceipt
    }
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
}
