import UIKit

final class AccountListTableViewCell: UITableViewCell {
    static let identifier = "AccountListTableViewCell"
    private lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    private lazy var accountCurrencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    private lazy var accountActionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .gray
        return label
    }()
    private lazy var transactionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        button.setTitle("TRANSACTIONS", for: .normal)
        button.addTarget(self, action: #selector(transactionsButtonAction), for: .touchUpInside)
        // NOTE: Transactions button hidden because feature is out of scope for this iteration
        button.isHidden = true
        return button
    }()
    private lazy var savingsGoalsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        button.setTitle("SAVINGS GOALS", for: .normal)
        button.addTarget(self, action: #selector(savingsGoalsButtonAction), for: .touchUpInside)
        return button
    }()
    var onTransactionButtonAction: (() -> Void)?
    var onSavingsGoalsButtonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(accountNameLabel)
        contentView.addSubview(accountCurrencyLabel)
        contentView.addSubview(accountActionDescriptionLabel)
        contentView.addSubview(transactionsButton)
        contentView.addSubview(savingsGoalsButton)
        NSLayoutConstraint.activate([
            accountNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            accountNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            accountCurrencyLabel.topAnchor.constraint(equalTo: accountNameLabel.topAnchor),
            accountCurrencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            accountActionDescriptionLabel.topAnchor.constraint(equalTo: accountNameLabel.bottomAnchor, constant: 10),
            accountActionDescriptionLabel.leadingAnchor.constraint(equalTo: accountNameLabel.leadingAnchor),
            accountActionDescriptionLabel.trailingAnchor.constraint(equalTo: accountCurrencyLabel.trailingAnchor),
            accountActionDescriptionLabel.bottomAnchor.constraint(equalTo: savingsGoalsButton.topAnchor, constant: -20),
            transactionsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            transactionsButton.bottomAnchor.constraint(equalTo: savingsGoalsButton.bottomAnchor),
            savingsGoalsButton.leadingAnchor.constraint(equalTo: accountActionDescriptionLabel.leadingAnchor),
            savingsGoalsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    @objc func transactionsButtonAction() {
        self.onTransactionButtonAction?()
    }
    
    @objc func savingsGoalsButtonAction() {
        self.onSavingsGoalsButtonAction?()
    }
    
    func configure(with viewModel: any AccountViewModelProtocol) {
        self.accountNameLabel.text = viewModel.name
        self.accountCurrencyLabel.text = viewModel.currency
        self.accountActionDescriptionLabel.text = "Did you know that with Starling Bank,"
        + " you can earn 3.25% AER* / 3.19% Gross* (variable) interest on balances up to £5,000 for personal and joint accounts. Chat with our support team to get setup today."
    }
}
