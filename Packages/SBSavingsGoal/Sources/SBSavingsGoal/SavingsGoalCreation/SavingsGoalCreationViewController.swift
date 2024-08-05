import UIKit
import SwiftUI

final class SavingsGoalCreationViewController: UIViewController {
    private var viewModel: (any SavingsGoalCreationViewModelProtocol)?
    private lazy var createButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createButtonAction))
        return button
    }()
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonAction))
        return button
    }()
    private lazy var savingsGoalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .gray
        return label
    }()
    private lazy var savingsGoalTitleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Holiday"
        textField.font = .systemFont(ofSize: 30, weight: .medium)
        textField.textAlignment = .center
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.delegate = self
        return textField
    }()
    private lazy var savingsGoalTargetTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "125.50"
        textField.font = .systemFont(ofSize: 30, weight: .medium)
        textField.textAlignment = .center
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.keyboardType = .decimalPad
        let leftLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        leftLabel.font = .systemFont(ofSize: 30, weight: .light)
        leftLabel.text = "£"
        textField.leftView = leftLabel
        textField.leftViewMode = .always
        textField.delegate = self
        return textField
    }()
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .medium
        activityIndicatorView.color = .gray
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    convenience init(viewModel: (any SavingsGoalCreationViewModelProtocol)?) {
        self.init()
        self.viewModel = viewModel
        if let viewModel = self.viewModel as? SavingsGoalCreationViewModel {
            viewModel.bindToRequestStream { [weak self] state in
                self?.onRequestStreamStateUpdated(state: state)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Create Savings Goal"
        setupViews()
        self.savingsGoalTitleTextField.becomeFirstResponder()
    }
    
    private func setupViews() {
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = createButton
        self.savingsGoalTitleLabel.text = "What are you saving for?"
        self.view.addSubview(self.savingsGoalTitleLabel)
        self.view.addSubview(self.savingsGoalTitleTextField)
        self.view.addSubview(self.savingsGoalTargetTextField)
        self.view.addSubview(self.activityIndicatorView)
        NSLayoutConstraint.activate([
            self.savingsGoalTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.savingsGoalTitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.savingsGoalTitleTextField.topAnchor.constraint(equalTo: self.savingsGoalTitleLabel.bottomAnchor, constant: 20),
            self.savingsGoalTitleTextField.centerXAnchor.constraint(equalTo: self.savingsGoalTitleLabel.centerXAnchor),
            self.savingsGoalTitleTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.savingsGoalTitleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.savingsGoalTargetTextField.topAnchor.constraint(equalTo: self.savingsGoalTitleTextField.bottomAnchor, constant: 20),
            self.savingsGoalTargetTextField.centerXAnchor.constraint(equalTo: self.savingsGoalTitleTextField.centerXAnchor, constant: 0),
            self.savingsGoalTargetTextField.widthAnchor.constraint(equalToConstant: 150),
            self.activityIndicatorView.topAnchor.constraint(equalTo: savingsGoalTargetTextField.bottomAnchor, constant: 20),
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.savingsGoalTargetTextField.centerXAnchor)
        ])
    }
    
    @objc func createButtonAction() {
        if let savingsGoalTitle = self.savingsGoalTitleTextField.text,
           let savingsGoalAmount = self.savingsGoalTargetTextField.text {
            print("Title: \(savingsGoalTitle), amount: \(savingsGoalAmount)")
            self.savingsGoalTitleTextField.resignFirstResponder()
            self.savingsGoalTargetTextField.resignFirstResponder()
            viewModel?.createSavingsGoal(title: savingsGoalTitle, targetAmount: savingsGoalAmount, currency: "GBP")
        }
    }
    
    @objc func cancelButtonAction() {
        self.dismiss(animated: true)
    }
    
    // MARK: - RequestStreamStateUpdated
    func onRequestStreamStateUpdated(state: SavingsGoalCreationViewModelLoadingState) {
        switch state {
        case .loading:
            print("Request in flight")
            self.activityIndicatorView.startAnimating()
        case .completed, .done:
            print("Request completed")
            self.activityIndicatorView.stopAnimating()
            self.dismiss(animated: true)
        case .error:
            print("Show Error Screen")
            self.activityIndicatorView.stopAnimating()
        }
    }
}

// MARK: - UITextField Delegate
extension SavingsGoalCreationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.returnKeyType {
        case .next:
            self.savingsGoalTargetTextField.becomeFirstResponder()
        case .done:
            self.savingsGoalTargetTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}

//MARK: - Previews
private struct SavingsGoalCreationViewController_Preview: UIViewControllerRepresentable {
    typealias UIViewControllerType = SavingsGoalCreationViewController

    func makeUIViewController(context: Context) -> SavingsGoalCreationViewController {
        return SavingsGoalCreationViewController()
    }

    func updateUIViewController(_ uiViewController: SavingsGoalCreationViewController, context: Context) {

    }
}

struct SavingsGoalCreationViewController_Provider: PreviewProvider {
    static var previews: some View {
        SavingsGoalCreationViewController_Preview()
    }
}
