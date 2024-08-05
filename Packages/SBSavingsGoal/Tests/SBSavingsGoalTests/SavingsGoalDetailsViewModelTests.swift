import XCTest
@testable import SBSavingsGoal

import SBCommonModels

final class SavingsGoalDetailsViewModelTests: XCTestCase {
    var mockSavingsGoalCoordinator: MockSavingsGoalCoordinator!
    var mockWebClient: MockWebClient!
    var mockSavingsGoalDetailsViewModelDelegate: MockSavingsGoalDetailsViewModelDelegate!
    var sut: SavingsGoalDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        self.mockSavingsGoalCoordinator = MockSavingsGoalCoordinator()
        self.mockWebClient = MockWebClient(baseUrl: "")
        self.mockSavingsGoalDetailsViewModelDelegate = MockSavingsGoalDetailsViewModelDelegate()
        self.sut = SavingsGoalDetailsViewModel(coordinator: mockSavingsGoalCoordinator,
                                               accountId: "123",
                                               categoryId: "4",
                                               savingsGoalId: "56",
                                               delegate: mockSavingsGoalDetailsViewModelDelegate,
                                               webClient: mockWebClient)
    }
    
    override func tearDown() {
        self.mockSavingsGoalCoordinator = nil
        self.mockWebClient = nil
        self.mockSavingsGoalDetailsViewModelDelegate = nil
        self.sut = nil
        super.tearDown()
    }
    
    func test_fetchRoundUpAmountFromSpendings_with_success_returns_correct_round_up_amount() async {
        let expectation = expectation(description: "Fetch round up amount from spendings expectation")
        let transactions = [
            Transaction(id: "123",
                        amount: Amount(currency: "GBP", minorUnits: 435),
                        spendingCategory: "PAYMENTS",
                        hasAttachment: false,
                        hasReceipt: false),
            Transaction(id: "456",
                        amount: Amount(currency: "GBP", minorUnits: 520),
                        spendingCategory: "PAYMENTS",
                        hasAttachment: false,
                        hasReceipt: false),
            Transaction(id: "789",
                        amount: Amount(currency: "GBP", minorUnits: 87),
                        spendingCategory: "PAYMENTS",
                        hasAttachment: false,
                        hasReceipt: false),
        ]
        mockWebClient.mockTransactions = transactions
        var receivedResponse: (minorUnits: Int, displayValue: String?) = (0,"")
        sut.bindToRoundUpAmountStream { response in
            receivedResponse = response
        }
        sut.bindToRequestStream { state in
            switch state {
            case .completed:
                expectation.fulfill()
            default: break
            }
        }
        sut.fetchRoundUpAmountFromSpendings(since: .oneWeek)
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(receivedResponse.minorUnits, 158, "Minor units should be 158")
        XCTAssertEqual(receivedResponse.displayValue, "£1.58", "Display amount should be £1.58")
    }
    
    func test_fetchRoundUpAmountFromSpendings_with_no_transactions_returns_zero_round_up_amount() async {
        let expectation = expectation(description: "Fetch round up amount from spendings expectation")
        var receivedResponse: (minorUnits: Int, displayValue: String?) = (0,"")
        sut.bindToRoundUpAmountStream { response in
            receivedResponse = response
        }
        sut.bindToRequestStream { state in
            switch state {
            case .completed:
                expectation.fulfill()
            default: break
            }
        }
        sut.fetchRoundUpAmountFromSpendings(since: .oneWeek)
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(receivedResponse.minorUnits, 0, "Minor units should be 0")
        XCTAssertEqual(receivedResponse.displayValue, "£0.00", "Display amount should be £0.00")
    }
    
    func test_fetchRoundUpAmountFromSpendings_with_error_returns_zero_round_up_amount() async {
        let expectation = expectation(description: "Fetch round up amount from spendings expectation")
        mockWebClient.shouldThrowError = true
        var receivedResponse: (minorUnits: Int, displayValue: String?) = (0,"")
        sut.bindToRoundUpAmountStream { response in
            receivedResponse = response
        }
        sut.bindToRequestStream { state in
            switch state {
            case.error:
                expectation.fulfill()
            default: break
            }
        }
        sut.fetchRoundUpAmountFromSpendings(since: .oneWeek)
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(receivedResponse.minorUnits, 0, "Minor units should be 0")
        XCTAssertEqual(receivedResponse.displayValue, "", "Display amount should be an empty string")
    }
    
    func test_addMoneyToSavingsGoal_with_158_minor_units_adds_correct_amount() async {
        let expectation = expectation(description: "Add money to savings goal")
        let minorUnits = 158
        mockWebClient.mockAddMoneyResponse = AddMoneyResponse(transferId: "123", success: true)
        sut.bindToRequestStream { state in
            switch state {
            case .completed:
                expectation.fulfill()
            default: break
            }
        }
        sut.addMoneyToSavingsGoal(roundUpAmount: minorUnits, currency: "GBP")
        await fulfillment(of: [expectation], timeout: 1)
        let isCalled = mockWebClient.addRoundUpToSavingsGoalIsCalled
        XCTAssertTrue(isCalled, "addRoundUpToSavingsGoalIsCalled should be true")
    }
    
    func test_addMoneyToSavingsGoal_with_failed_transfer_returns_error() async {
        let expectation = expectation(description: "Add money to savings goal")
        let minorUnits = 158
        mockWebClient.mockAddMoneyResponse = AddMoneyResponse(transferId: "123", success: false)
        sut.bindToRequestStream { state in
            switch state {
            case .error:
                expectation.fulfill()
            default: break
            }
        }
        sut.addMoneyToSavingsGoal(roundUpAmount: minorUnits, currency: "GBP")
        await fulfillment(of: [expectation], timeout: 1)
        let isCalled = mockWebClient.addRoundUpToSavingsGoalIsCalled
        XCTAssertTrue(isCalled, "addRoundUpToSavingsGoalIsCalled should be true")
    }
    
    func test_addMoneyToSavingsGoal_with_error_returns_error() async {
        let expectation = expectation(description: "Add money to savings goal")
        //mockWebClient.mockAddMoneyResponse = AddMoneyResponse(transferId: "123", success: false)
        mockWebClient.shouldThrowError = true
        sut.bindToRequestStream { state in
            switch state {
            case .error:
                expectation.fulfill()
            default: break
            }
        }
        sut.addMoneyToSavingsGoal(roundUpAmount: 1254, currency: "GBP")
        await fulfillment(of: [expectation], timeout: 1)
        let isCalled = mockWebClient.addRoundUpToSavingsGoalIsCalled
        XCTAssertTrue(isCalled, "addRoundUpToSavingsGoalIsCalled should be true")
    }
    
    func test_addMoneyToSavingsGoal_with_158_minor_units_calls_delegate_with_correct_values() async {
        let expectation = expectation(description: "Add money to savings goal")
        let minorUnits = 158
        mockWebClient.mockAddMoneyResponse = AddMoneyResponse(transferId: "123", success: true)
        sut.bindToRequestStream { state in
            switch state {
            case .completed:
                expectation.fulfill()
            default: break
            }
        }
        sut.addMoneyToSavingsGoal(roundUpAmount: minorUnits, currency: "GBP")
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertTrue(mockSavingsGoalDetailsViewModelDelegate.didAddIsCalled, "addRoundUpToSavingsGoalIsCalled should be true")
        XCTAssertEqual(mockSavingsGoalDetailsViewModelDelegate.minorUnits, 158, "Minor units should be 158")
        XCTAssertEqual(mockSavingsGoalDetailsViewModelDelegate.savingsGoalId, "56", "Savings goal id should be 56")
    }
}
