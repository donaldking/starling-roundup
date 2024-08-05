import UIKit
import SwiftUI

import SBCommonModels

final class SavingsGoalListViewController: UIViewController {
    private var accountId: String?
    private var viewModel: SavingsGoalListViewModelProtocol?
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .medium
        activityIndicatorView.color = .gray
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    private lazy var createSevingsGoalBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createSevingsGoalBarButtonAction))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Savings Goals"
        setupViews()
        loadDataIfNeeded()
    }
    
    convenience init(accountId: String, viewModel: (any SavingsGoalListViewModelProtocol)?) {
        self.init()
        self.accountId = accountId
        self.viewModel = viewModel
        if let viewModel = self.viewModel as? SavingsGoalListViewModel {
            viewModel.bindToRequestStream { [weak self] state in
                self?.onRequestStreamStateUpdated(state: state)
            }
        }
    }
    
    private func setupViews() {
        self.navigationItem.rightBarButtonItem = createSevingsGoalBarButton
        self.tableView.register(SavingsGoalTableViewCell.self, forCellReuseIdentifier: SavingsGoalTableViewCell.identifier)
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension
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
        self.tableView.numberOfRows(inSection: 0) == 0 ? self.viewModel?.loadSavingsGoals(accountId: self.accountId!) : ()
    }
    
    @objc func createSevingsGoalBarButtonAction() {
        self.viewModel?.createSavingGoalButtonAction()
    }
    
    // MARK: - RequestStreamStateUpdated
    func onRequestStreamStateUpdated(state: SavingsGoalListViewModelLoadingState) {
        switch state {
        case .loading:
            self.activityIndicatorView.startAnimating()
        case .completed, .done:
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        case .error:
            self.activityIndicatorView.stopAnimating()
        }
    }
}


// MARK: - UITableViewDataSource
extension SavingsGoalListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfSavingsGoals() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavingsGoalTableViewCell.identifier, for: indexPath) as? SavingsGoalTableViewCell else { fatalError("Unable to dequeue cell with identifier - \(SavingsGoalTableViewCell.identifier)")}
        guard let savingsGoalViewModel = viewModel?.savingsGoalForRow(row: indexPath.row) else { return UITableViewCell() }
        cell.configure(with: savingsGoalViewModel)
        return cell
    }
}

// MARK: -  UITableViewDelegate
extension SavingsGoalListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel?.didSelectSavingsGoal(atIndex: indexPath.row)
    }
}

//MARK: - Previews
struct SavingsGoalListViewController_Preview: UIViewControllerRepresentable {
    typealias UIViewControllerType = SavingsGoalListViewController
    
    func makeUIViewController(context: Context) -> SavingsGoalListViewController {
        let savingsGoal = SavingsGoal(id: "123",
                                      name: "Trip to Paris",
                                      target: Target(currency: "GBP", minorUnits: 25036),
                                      totalSaved: TotalSaved(currency: "GBP", minorUnits: 1762),
                                      savedPercentage: 7,
                                      state: "active")
        let savingsGoalViewModels = [SavingsGoalViewModel(savingsGoal: savingsGoal)]
        let viewModels = SavingsGoalListViewModel(coordinator: MockSavingsGoalCoordinator(),
                                                  accountId: "!23",
                                                  webClient: MockWebClient(baseUrl: ""),
                                                  savingsGoalsViewModels: savingsGoalViewModels)
        return SavingsGoalListViewController(accountId: "123", viewModel: viewModels)
    }
    
    func updateUIViewController(_ uiViewController: SavingsGoalListViewController, context: Context) {
        
    }
}

struct SavingsGoalListViewController_Provider: PreviewProvider {
    static var previews: some View {
        SavingsGoalListViewController_Preview()
    }
}
