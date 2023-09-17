import UIKit

class HomeView: UIView {
    var segmentedControlTopConstraint: NSLayoutConstraint?

    let segmentedControl: UISegmentedControl = {
        let customColor = UIColor(
            red: 110/255, green: 83/255, blue: 211/255, alpha: 1.0
        )
        let control = UISegmentedControl(items: ["Movies", "TV Shows"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.apportionsSegmentWidthsByContent = true
        control.backgroundColor = customColor
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(.comfortaaRegular, ofSize: 14) as Any,
            .foregroundColor: UIColor.white
        ]
        control.setTitleTextAttributes(
            normalAttributes,
            for: .normal
        )
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(.comfortaaSemiBold, ofSize: 18) as Any,
            .foregroundColor: UIColor.black
        ]
        control.setTitleTextAttributes(
            selectedAttributes,
            for: .selected
        )
        return control
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingUIElementsAndConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(segmentedControl)
        segmentedControlTopConstraint = segmentedControl.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor,
            constant: 16
        )
    }
    
    private func settingUIElementsAndConstraints() {
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
    }
}
