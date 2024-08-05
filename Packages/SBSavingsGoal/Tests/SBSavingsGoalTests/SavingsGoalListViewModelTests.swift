import XCTest
@testable import SBSavingsGoal

import SBCommonModels

final class SavingsGoalListViewModelTests: XCTestCase {
    var mockSavingsGoalCoordinator: MockSavingsGoalCoordinator!
    var mockWebClient: MockWebClient!
    
    var sut: SavingsGoalListViewModel!
    
    override func setUp() {
        super.setUp()
        self.mockSavingsGoalCoordinator = MockSavingsGoalCoordinator()
        self.mockWebClient = MockWebClient(baseUrl: "")
        self.sut = SavingsGoalListViewModel(coordinator: mockSavingsGoalCoordinator,
                                            accountId: "123",
                                            webClient: mockWebClient,
                                            savingsGoalsViewModels: [])
    }
    
    override func tearDown() {
        self.mockSavingsGoalCoordinator = nil
        self.mockWebClient = nil
        self.sut = nil
        super.tearDown()
    }
    
    func test_loadSavingsGoals_returns_one_savings_goal_with_correct_information() async {
        let expectation = expectation(description: "Load savings goals expectation")
        let savingsGoal = SavingsGoal(id: "123", name: "Trip to London")
        mockWebClient.mockSavingsGoals = [savingsGoal]
        sut.bindToRequestStream { state in
            switch state {
            case .completed:
                expectation.fulfill()
            default:
                break
            }
        }
        sut.loadSavingsGoals(accountId: "123")
        await fulfillment(of: [expectation], timeout: 1)
        let receivedGoal = sut.savingsGoalForRow(row: 0)!
        XCTAssertEqual(sut.numberOfSavingsGoals(), 1, "Number of savings goals should be 1")
        XCTAssertEqual(receivedGoal.id, "123", "Savings goal id should be 123")
        XCTAssertEqual(receivedGoal.name, "Trip to London", "Savings goal name should be Trip to London")
    }
    
    func test_loadSavingsGoals_for_error_returns_zero_savings_goal_with_error_state() async {
        let expectation = expectation(description: "Load savings goals expectation")
        mockWebClient.shouldThrowError = true
        sut.bindToRequestStream { state in
            switch state {
            case .error:
                expectation.fulfill()
            default:
                break
            }
        }
        sut.loadSavingsGoals(accountId: "123")
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(sut.numberOfSavingsGoals(), 0, "Number of savings goals should be 0")
    }
    
    func test_addSavingsGoalViewModel_adds_savings_goal_view_model() {
        let savingsGoal1 = SavingsGoal(id: "123", name: "Trip to London")
        let savingsGoal2 = SavingsGoal(id: "456", name: "Pool Party")
        let viewModel1 = SavingsGoalViewModel(savingsGoal: savingsGoal1)
        let viewModel2 = SavingsGoalViewModel(savingsGoal: savingsGoal2)
        sut.addSavingsGoalViewModel(savingsGoalViewModel: viewModel1)
        sut.addSavingsGoalViewModel(savingsGoalViewModel: viewModel2)
        XCTAssertEqual(sut.numberOfSavingsGoals(), 2, "Number of savings goals should be 2")
    }
    
    func test_savingsGoalForRow_at_given_row_returns_correct_savings_goal() {
        let savingsGoal1 = SavingsGoal(id: "123", name: "Trip to London")
        let savingsGoal2 = SavingsGoal(id: "456", name: "Pool Party")
        let viewModel1 = SavingsGoalViewModel(savingsGoal: savingsGoal1)
        let viewModel2 = SavingsGoalViewModel(savingsGoal: savingsGoal2)
        sut.addSavingsGoalViewModel(savingsGoalViewModel: viewModel1)
        sut.addSavingsGoalViewModel(savingsGoalViewModel: viewModel2)
        let receivedSavingsGoal = sut.savingsGoalForRow(row: 1)!
        XCTAssertEqual(receivedSavingsGoal.id, "456", "Savings goal id should be 456")
        XCTAssertEqual(receivedSavingsGoal.name, "Pool Party", "Savings goal name should be Pool Party")
    }
    
    func test_didSelectSavingsGoal_at_index_one_selects_correct_savings_goal() {
        let savingsGoal1 = SavingsGoal(id: "123", name: "Trip to London")
        let savingsGoal2 = SavingsGoal(id: "456", name: "Pool Party")
        let viewModel1 = SavingsGoalViewModel(savingsGoal: savingsGoal1)
        let viewModel2 = SavingsGoalViewModel(savingsGoal: savingsGoal2)
        sut.addSavingsGoalViewModel(savingsGoalViewModel: viewModel1)
        sut.addSavingsGoalViewModel(savingsGoalViewModel: viewModel2)
        sut.didSelectSavingsGoal(atIndex: 1)
        let isCalled = mockSavingsGoalCoordinator.goToSavingsGoalDetailsCalled
        XCTAssertTrue(isCalled, "goToSavingsGoalDetailsCalled should be true")
    }
    
    func test_createSavingGoalButtonAction_is_called() {
        sut.createSavingGoalButtonAction()
        let isCalled = mockSavingsGoalCoordinator.goToCreateSavingGoalsScreeenCalled
        XCTAssertTrue(isCalled, "goToCreateSavingGoalsScreeenCalled should be true")
    }
}
