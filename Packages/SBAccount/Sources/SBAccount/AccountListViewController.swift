import UIKit
import SwiftUI

import SBCommonModels
import SBDependencyContainer
import SBTransactionInterface
import SBSavingsGoalInterface
import SBFoundation

final class AccountListViewController: UIViewController {
    private var viewModel: (any AccountListViewModelProtocol)?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .medium
        activityIndicatorView.color = .gray
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Accounts"
        setupViews()
        loadDataIfNeeded()
    }
    
    convenience init(viewModel: (any AccountListViewModelProtocol)?) {
        self.init()
        self.viewModel = viewModel
        if let viewModel = self.viewModel as? AccountListViewModel {
            viewModel.bindToRequestStream { [weak self] state in
                self?.onRequestStreamStateUpdated(state: state)
            }
        }
    }
    
    private func setupViews() {
        self.tableView.register(AccountListTableViewCell.self, forCellReuseIdentifier: AccountListTableViewCell.identifier)
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.allowsSelection = false
        self.tableView.addSubview(self.activityIndicatorView)
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadDataIfNeeded() {
        self.tableView.numberOfRows(inSection: 0) == 0 ? self.viewModel?.loadAccounts() : ()
    }
    
    // MARK: - RequestStreamStateUpdated
    func onRequestStreamStateUpdated(state: AccountListViewModelLoadingState) {
        switch state {
        case .loading:
            self.activityIndicatorView.startAnimating()
        case .completed, .done:
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        case .error:
            print("Show Error Screen")
        }
    }
}

// MARK: - UITableViewDataSource
extension AccountListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfAccounts() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountListTableViewCell.identifier, for: indexPath) as? AccountListTableViewCell 
        else { fatalError("Unable to dequeue cell with identifier - \(AccountListTableViewCell.identifier)")}
        guard let accountViewModel = viewModel?.accountForRow(row: indexPath.row) else { return UITableViewCell() }
        cell.configure(with: accountViewModel)
        cell.onTransactionButtonAction = { [weak self] in
            self?.handleTransactionsButtonAction(at: indexPath, 
                                                 accountId: accountViewModel.id,
                                                 categoryId: accountViewModel.defaultCatgoryId,
                                                 timeAgo: .oneWeek)
        }
        cell.onSavingsGoalsButtonAction = { [weak self] in
            self?.handleSavingsGoalsButtonAction(at: indexPath, accountId: accountViewModel.id, categoryId: accountViewModel.defaultCatgoryId)
        }
        return cell
    }
    
    // MARK: - Cell button handlers
    private func handleTransactionsButtonAction(at indexPath: IndexPath,
                                                accountId: String,
                                                categoryId: String,
                                                timeAgo: SBTimeAgo) 
    {
        self.viewModel?.goToTransactions(accountId: accountId,
                                                     categoryId: categoryId,
                                                     timeAgo: timeAgo)
    }
    
    private func handleSavingsGoalsButtonAction(at indexPath: IndexPath, accountId: String, categoryId: String) {
        self.viewModel?.goToSavingsGoals(accountId: accountId, categoryId: categoryId)
    }
}

// MARK: - UITableViewDelegate
extension AccountListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - Previews
struct AccountListViewController_Preview: UIViewControllerRepresentable {
    typealias UIViewControllerType = AccountListViewController
    
    func makeUIViewController(context: Context) -> AccountListViewController {
        let account = Account(id: "123", 
                              type: "Primary",
                              name: "Personal",
                              defaultCategoryId: "123",
                              currency: "USD")
        let viewModel = AccountViewModel(account: account)
        let accountListViewModel = AccountListViewModel(coordinator: MockAccountCoordinator(),
                                                        webClient: MockWebClient(baseUrl: "none"),
                                                        accountViewModels: [viewModel])
        return AccountListViewController(viewModel: accountListViewModel)
    }
    
    func updateUIViewController(_ uiViewController: AccountListViewController, context: Context) {
        
    }
}

struct AccountListViewController_Provider: PreviewProvider {
    static var previews: some View {
        AccountListViewController_Preview()
    }
}
