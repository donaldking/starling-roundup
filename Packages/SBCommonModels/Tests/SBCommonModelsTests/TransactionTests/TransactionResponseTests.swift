import XCTest
@testable import SBCommonModels

final class TransactionResponseTests: XCTestCase {
    var sut: TransactionResponse!
    
    override func setUp() {
        let jsonData = try! JSONLoader.loadJSON(from: "transactions_response")
        sut = try! JSONDecoder().decode(TransactionResponse.self, from: jsonData)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_transactionResponse_decoding() {
        XCTAssertEqual(sut.transactionItems.count, 1, "There should be exactly one transaction item")
        XCTAssertEqual(sut.transactionItems.first!.id, "123", "The transaction ID should match the JSON")
    }
    
    func test_amount_decoding() {
        let amount = sut.transactionItems.first!.amount!
        XCTAssertEqual(amount.currency, "GBP", "Currency should be 'GBP'")
        XCTAssertEqual(amount.minorUnits, 1250, "Minor units should be 1250")
    }
    
    func test_source_amount_decoding() {
        let sourceAmount = sut.transactionItems.first!.sourceAmount!
        XCTAssertEqual(sourceAmount.currency, "USD", "Currency should be 'GBP''")
        XCTAssertEqual(sourceAmount.minorUnits, 1600, "Minor units should be 1234")
    }
    
    func test_transaction_response() {
        let transaction = sut.transactionItems.first!
        XCTAssertEqual(transaction.id, "123", "The transaction ID should match the JSON")
        XCTAssertEqual(transaction.amount?.minorUnits, 1250, "Amount minor units should be 1250")
        XCTAssertEqual(transaction.spendingCategory, "PAYMENTS", "Spending category should be 'PAYMENTS'")
        XCTAssertTrue(transaction.hasAttachment, "hasAttachment should be true")
        XCTAssertTrue(transaction.hasReceipt, "hasReceipt should be true")
    }
    
    func test_roundUpMinorUnits_with_1_transaction_of_1250_rounds_up_to_50() {
        let transactionItem = sut.transactionItems.first!
        let roundUpAmount = transactionItem.roundUpAmountInMinorUnits()
        XCTAssertEqual(roundUpAmount, 50, "Round up amount should be 50 minor units")
    }
    
    func test_roundUpAmountInMinorUnits_with_3_transactions_of_435_520_87_rounds_up_to_158() {
        let amount1 = Amount(currency: "GBP", minorUnits: 435)
        let amount2 = Amount(currency: "GBP", minorUnits: 520)
        let amount3 = Amount(currency: "GBP", minorUnits: 87)
        let transaction1 = Transaction(amount: amount1, spendingCategory: "PAYMENTS", hasAttachment: false, hasReceipt: false)
        let transaction2 = Transaction(amount: amount2, spendingCategory: "PAYMENTS", hasAttachment: false, hasReceipt: false)
        let transaction3 = Transaction(amount: amount3, spendingCategory: "PAYMENTS", hasAttachment: false, hasReceipt: false)
        let roundUpAmount1 = transaction1.roundUpAmountInMinorUnits()
        let roundUpAmount2 = transaction2.roundUpAmountInMinorUnits()
        let roundUpAmount3 = transaction3.roundUpAmountInMinorUnits()
        let totalRoundUpAmount = roundUpAmount1 + roundUpAmount2 + roundUpAmount3
        XCTAssertEqual(totalRoundUpAmount, 158)
    }
}
