import UIKit
import SwiftUI

import SBCommonModels

class SavingsGoalTableViewCell: UITableViewCell {
    static let identifier = "SavingsGoalTableViewCell"
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .black
        return label
    }()
    private lazy var targetAmountlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    private lazy var totalSavedAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    private lazy var savedPercentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(targetAmountlabel)
        contentView.addSubview(totalSavedAmountLabel)
        contentView.addSubview(savedPercentageLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            targetAmountlabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            targetAmountlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            totalSavedAmountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            totalSavedAmountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            savedPercentageLabel.topAnchor.constraint(equalTo: totalSavedAmountLabel.bottomAnchor, constant: 20),
            savedPercentageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            savedPercentageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    public func configure(with viewModel: any SavingsGoalViewModelProtocol) {
        self.nameLabel.text = viewModel.name
        self.targetAmountlabel.text = "Target \(viewModel.targetAmountDisplay)"
        self.totalSavedAmountLabel.text = "Saved: \(viewModel.totalSavedDisplay)"
        self.savedPercentageLabel.text = "Goal Achieved: \(viewModel.savedPercentageDisplay)"
    }
}
