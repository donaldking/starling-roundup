import UIKit
import SwiftUI

final class TransactionViewController: UIViewController {
    private var viewModel: (any TransactionListViewModelProtocol)?
    private lazy var notificationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Transactions"
        self.notificationLabel.text = "Not Implemented"
        self.view.addSubview(notificationLabel)
        NSLayoutConstraint.activate([
            self.notificationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.notificationLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    convenience init(viewModel: (any TransactionListViewModelProtocol)?) {
        self.init()
        self.viewModel = viewModel
    }
}

// MARK: - Previews
struct Preview: UIViewControllerRepresentable {
    typealias UIViewControllerType = TransactionViewController
    
    func makeUIViewController(context: Context) -> TransactionViewController {
        TransactionViewController()
    }
    
    func updateUIViewController(_ uiViewController: TransactionViewController, context: Context) {
        
    }
}

struct Provider: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}
