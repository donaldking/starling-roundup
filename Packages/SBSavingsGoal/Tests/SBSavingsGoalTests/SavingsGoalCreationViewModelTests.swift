import XCTest

@testable import SBSavingsGoal
import SBCommonModels

final class SavingsGoalCreationViewModelTests: XCTestCase {
    var mockWebClient: MockWebClient!
    var mockSavingsGoalCreationViewModelDelegate: MockSavingsGoalCreationViewModelDelegate!
    var sut: SavingsGoalCreationViewModel!
    
    override func setUp() {
        super.setUp()
        mockWebClient = MockWebClient(baseUrl: "")
        mockSavingsGoalCreationViewModelDelegate = MockSavingsGoalCreationViewModelDelegate()
        sut = SavingsGoalCreationViewModel(accountId: "123",
                                           webClient: mockWebClient,
                                           delegate: mockSavingsGoalCreationViewModelDelegate)
    }
    
    override func tearDown() {
        mockWebClient = nil
        mockSavingsGoalCreationViewModelDelegate = nil
        sut = nil
        super.tearDown()
    }
    
    func test_create_savings_goal_with_success_creates_correct_savings_goal() async {
        let expectation = expectation(description: "Create savings goal expectation")
        let createSavingsGoalResponse = CreateSavingsGoalResponse(savingsGoalId: "56", success: true)
        mockWebClient.mockCreateSavingsGoalResponse = createSavingsGoalResponse
        sut.bindToRequestStream { state in
            switch state {
            case .completed:
                expectation.fulfill()
            default: break
            }
        }
        sut.createSavingsGoal(title: "Summer Holiday", targetAmount: "2500", currency: "GBP")
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertTrue(mockSavingsGoalCreationViewModelDelegate.didCreateSavingsGoalIsCalled, "didCreateSavingsGoalIsCalled should be true")
        XCTAssertEqual(mockSavingsGoalCreationViewModelDelegate.savingsGoalId, "56", "Savings goal id should be 56")
    }
    
    func test_create_savings_goal_with_failure_should_return_error() async {
        let expectation = expectation(description: "Create savings goal expectation")
        let createSavingsGoalResponse = CreateSavingsGoalResponse(savingsGoalId: "56", success: false)
        mockWebClient.mockCreateSavingsGoalResponse = createSavingsGoalResponse
        sut.bindToRequestStream { state in
            switch state {
            case .error:
                expectation.fulfill()
            default: break
            }
        }
        sut.createSavingsGoal(title: "Summer Holiday", targetAmount: "2500", currency: "GBP")
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertFalse(mockSavingsGoalCreationViewModelDelegate.didCreateSavingsGoalIsCalled, "didCreateSavingsGoalIsCalled should be false")
    }
}
