import XCTest
@testable import SBAccount

import SBWebClientInterface
import SBFoundation
import SBCommonModels

final class AccountListViewModelTests: XCTestCase {
    var sut: AccountListViewModel!
    var mockCoordinator: MockAccountCoordinator!
    var mockWebClient: MockWebClient!
    
    override func setUp() {
        super.setUp()
        mockCoordinator = MockAccountCoordinator()
        mockWebClient = MockWebClient(baseUrl: "")
        sut = AccountListViewModel(coordinator: mockCoordinator, webClient: mockWebClient, accountViewModels: [])
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func test_loadAccounts_returns_one_account_with_correct_information() async {
        let expectation = expectation(description: "Load accounts expectation")
        let account = Account(id: "123", name: "DummyAccount", currency: "USD")
        mockWebClient.mockAccounts = [account]
        sut.bindToRequestStream { state in
            switch state {
            case .completed:
                expectation.fulfill()
            default:
                break
            }
        }
        sut.loadAccounts()
        await fulfillment(of: [expectation], timeout: 1)
        let receivedAccount = sut.accountForRow(row: 0)!
        XCTAssertEqual(sut.numberOfAccounts(), 1, "Number of accounts should be 1")
        XCTAssertEqual(receivedAccount.id, "123", "Account id should be 123")
        XCTAssertEqual(receivedAccount.name, "DummyAccount", "Account name should be DummyAccount")
        XCTAssertEqual(receivedAccount.currency, "USD", "Account currency should be USD")
    }
    
    func test_loadAccounts_for_error_returns_zero_account_with_error_state() async {
        let expectation = expectation(description: "Load accounts expectation")
        mockWebClient.shouldThrowError = true
        sut = AccountListViewModel(coordinator: mockCoordinator, webClient: mockWebClient, accountViewModels: [])
        sut.bindToRequestStream { state in
            switch state {
            case .error:
                expectation.fulfill()
            default:
                break
            }
        }
        sut.loadAccounts()
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(sut.numberOfAccounts(), 0, "Number of accounts should be 0")
    }
    
    func test_addAccountViewModel_adds_account() {
        let account1 = Account(id: "123", name: "DummyAccount", currency: "USD")
        let account2 = Account(id: "456", name: "DummyAccount2", currency: "GBP")
        let viewModel1 = AccountViewModel(account: account1)
        let viewModel2 = AccountViewModel(account: account2)
        sut.addAccountViewModel(viewModel: viewModel1)
        sut.addAccountViewModel(viewModel: viewModel2)
        XCTAssertEqual(sut.numberOfAccounts(), 2, "Number of accounts should be 2")
    }
    
    func test_accountForRow_at_given_row_returns_correct_account() {
        let account1 = Account(id: "123", name: "DummyAccount", currency: "USD")
        let account2 = Account(id: "456", name: "DummyAccount2", currency: "GBP")
        let viewModel1 = AccountViewModel(account: account1)
        let viewModel2 = AccountViewModel(account: account2)
        sut.addAccountViewModel(viewModel: viewModel1)
        sut.addAccountViewModel(viewModel: viewModel2)
        let receivedAccount = sut.accountForRow(row: 1)!
        XCTAssertEqual(receivedAccount.id, "456", "Number of accounts should be 2")
    }
    
    func test_goToTransactions_is_called() {
        sut.goToTransactions(accountId: "123", categoryId: "456", timeAgo: .oneWeek)
        let isCalled = mockCoordinator.goToTransactionsCalled
        XCTAssertTrue(isCalled, "goToTransactionsCalled should be true")
    }
    
    func test_goToSavingsGoals_is_called() {
        sut.goToSavingsGoals(accountId: "123", categoryId: "456")
        let isCalled = mockCoordinator.goToSavingsGoalsCalled
        XCTAssertTrue(isCalled, "goToSavingsGoalsCalled should be true")
    }
}
