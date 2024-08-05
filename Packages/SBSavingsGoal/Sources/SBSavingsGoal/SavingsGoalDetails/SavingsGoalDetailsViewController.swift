import UIKit
import SwiftUI

final class SavingsGoalDetailsViewController: UIViewController {
    private var viewModel: (any SavingsGoalDetailsViewModelProtocol)?
    private lazy var benefitsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    private lazy var roundUpTypeInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private lazy var roundUpTypeInfoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var oneWeekButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .medium)
        button.setTitle("[1 WEEK AGO]", for: .normal)
        button.addTarget(self, action: #selector(oneWeekAgoButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var twoWeekButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .medium)
        button.setTitle("[2 WEEKS AGO]", for: .normal)
        button.addTarget(self, action: #selector(twoWeekAgoButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var threeWeekButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .medium)
        button.setTitle("[3 WEEKS AGO]", for: .normal)
        button.addTarget(self, action: #selector(threeWeekAgoButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var fourWeeksButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .medium)
        button.setTitle("[4 WEEKS AGO]", for: .normal)
        button.addTarget(self, action: #selector(fourWeekAgoButtonAction), for: .touchUpInside)
        return button
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
        setupUI()
    }
    
    convenience init(viewModel: (any SavingsGoalDetailsViewModelProtocol)? = nil) {
        self.init()
        self.viewModel = viewModel
        if let viewModel = self.viewModel as? SavingsGoalDetailsViewModel {
            viewModel.bindToRequestStream { [weak self] state in
                self?.onRequestStreamStateUpdated(state: state)
            }
            viewModel.bindToRoundUpAmountStream { [weak self] roundUpAmount in
                self?.onRoundUpAmountReceived(roundUpAmount: roundUpAmount)
            }
        }
    }
    
    func setupUI() {
        self.benefitsLabel.text = "Benefits"
        self.infoLabel.text = "* We built Saving Spaces because we believe that visualising all the great things you’re saving for (and viewing them as individual objectives) means you’ll get there faster.\n\n * Transfer money in and out of Spaces with a few taps. Or use our Split payment tool to spread money across different Spaces and accounts in one go. \n\n * Personalise your Space by giving it a name and a photo. It helps to keep your eye on the prize."
        self.roundUpTypeInfoTitleLabel.text = "How do you want to roundup?"
        self.roundUpTypeInfoDescriptionLabel.text = "Choose which week's transactions you'd like to roundup to the nearest pound, and added to this savings goal."
        
        self.view.addSubview(self.benefitsLabel)
        self.view.addSubview(self.roundUpTypeInfoTitleLabel)
        self.view.addSubview(self.infoLabel)
        self.view.addSubview(self.roundUpTypeInfoDescriptionLabel)
        self.view.addSubview(self.buttonStackView)
        self.view.addSubview(self.activityIndicatorView)
        self.buttonStackView.addArrangedSubview(self.oneWeekButton)
        self.buttonStackView.addArrangedSubview(self.twoWeekButton)
        self.buttonStackView.addArrangedSubview(self.threeWeekButton)
        self.buttonStackView.addArrangedSubview(self.fourWeeksButton)
        NSLayoutConstraint.activate([
            self.benefitsLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            self.benefitsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.benefitsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.infoLabel.topAnchor.constraint(equalTo: self.benefitsLabel.bottomAnchor, constant: 10),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.infoLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.roundUpTypeInfoTitleLabel.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 40),
            self.roundUpTypeInfoTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.roundUpTypeInfoTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.roundUpTypeInfoDescriptionLabel.topAnchor.constraint(equalTo: self.roundUpTypeInfoTitleLabel.bottomAnchor, constant: 10),
            self.roundUpTypeInfoDescriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.roundUpTypeInfoDescriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.buttonStackView.topAnchor.constraint(equalTo: self.roundUpTypeInfoDescriptionLabel.bottomAnchor, constant: 20),
            self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.buttonStackView.heightAnchor.constraint(equalTo: self.oneWeekButton.heightAnchor),
            self.activityIndicatorView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.buttonStackView.centerXAnchor)
        ])
    }
    
    @objc func oneWeekAgoButtonAction() {
        print("oneWeekAgoButtonAction pressed")
        viewModel?.fetchRoundUpAmountFromSpendings(since: .oneWeek)
    }
    
    @objc func twoWeekAgoButtonAction() {
        print("twoWeekAgoButtonAction pressed")
        viewModel?.fetchRoundUpAmountFromSpendings(since: .twoWeeks)
    }
    
    @objc func threeWeekAgoButtonAction() {
        print("threeWeekAgoButtonAction pressed")
        viewModel?.fetchRoundUpAmountFromSpendings(since: .threeWeeks)
    }
    
    @objc func fourWeekAgoButtonAction() {
        print("fourWeekAgoButtonAction pressed")
        viewModel?.fetchRoundUpAmountFromSpendings(since: .fourWeeks)
    }
    
    private func showAlertFor(roundUpAmount: (rawValue: Int, displayValue: String?)) {
        let alertController = UIAlertController(title: "Confirm Action", message: "Add roundup amount of \(roundUpAmount.displayValue ?? "") to this savings goal?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            // NOTE: Sending GBP as the currency to add. Will modify this to use value from the savings goal target currency
            self?.viewModel?.addMoneyToSavingsGoal(roundUpAmount: roundUpAmount.rawValue, currency: "GBP")
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showAlertForNoTransaction() {
        let alertController = UIAlertController(title: "No Transactions", message: "No transactions found for the selected week", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - ViewModel to View Bindings
    func onRequestStreamStateUpdated(state: SavingsGoalDetailsViewModelLoadingState) {
        switch state {
        case .loading:
            print("Request in flight")
            self.activityIndicatorView.startAnimating()
        case .completed, .done:
            print("Request completed")
            self.activityIndicatorView.stopAnimating()
        case .error:
            print("Show Error Screen")
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func onRoundUpAmountReceived(roundUpAmount: (rawValue: Int, displayValue: String?)) {
        print("Roundup amount received: \(roundUpAmount)")
        roundUpAmount.rawValue > 0 ? showAlertFor(roundUpAmount: roundUpAmount) : showAlertForNoTransaction()
    }
    
    deinit {
        print("SavingsGoalDetailsViewController deinit")
    }
}

//MARK: - Previews
struct SavingsGoalDetailsViewController_Preview: UIViewControllerRepresentable {
    typealias UIViewControllerType = SavingsGoalDetailsViewController
    
    func makeUIViewController(context: Context) -> SavingsGoalDetailsViewController {
        return SavingsGoalDetailsViewController(viewModel: nil)
    }
    
    func updateUIViewController(_ uiViewController: SavingsGoalDetailsViewController, context: Context) {
        
    }
}

struct SavingsGoalDetailsViewController_Provider: PreviewProvider {
    static var previews: some View {
        SavingsGoalDetailsViewController_Preview()
    }
}
