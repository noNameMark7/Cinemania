import UIKit

// MARK: - HomeView

class HomeView: UIView {
    
    // MARK: - Properties
    
    var segmentedControlTopConstraint: NSLayoutConstraint?

    let segmentedControl: UISegmentedControl = {
        
        let control = UISegmentedControl(items: ["Movies", "TV shows"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.1725490196, blue: 0.537254902, alpha: 1)
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.customFont(.comfortaaMedium, ofSize: 14) ?? .systemFont(ofSize: 14)
        ]
        control.setTitleTextAttributes(
            normalAttributes,
            for: .normal
        )
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.customFont(.comfortaaMedium, ofSize: 14) ?? .systemFont(ofSize: 14)
        ]
        control.setTitleTextAttributes(
            selectedAttributes,
            for: .selected
        )
        
        return control
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    /// This initializer is required if the Storyboard.main file is used,
    /// if it is not used in the project, then you can use this signature @available(*, unavailable)
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Initial setup

extension HomeView {
    
    func initialSetup() {
        configureUI()
    }
    
    func configureUI() {
        addSubview(segmentedControl)
        addSubview(tableView)
        
        let segmentedControlConstraints = [
            segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(segmentedControlConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)
        
        addSubview(segmentedControl)
        segmentedControlTopConstraint = segmentedControl.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor,
            constant: 16
        )
    }
}
