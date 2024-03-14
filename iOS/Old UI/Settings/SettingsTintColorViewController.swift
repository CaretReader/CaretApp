//
//  SettingsTintColorViewController.swift
//  Caret (iOS)
//

import UIKit

class SettingsTintColorViewController: UITableViewController {

    var checkedIndexPath: IndexPath?

    fileprivate struct TintColor {
        var key: String
        var title: String
        var color: UIColor
    }

    fileprivate let tintColors: [TintColor] = [
        TintColor(key: "systemBlue", title: NSLocalizedString("BLUE", comment: ""), color: .systemBlue),
        TintColor(key: "systemIndigo", title: NSLocalizedString("INDIGO", comment: ""), color: .systemIndigo),
        TintColor(key: "systemPurple", title: NSLocalizedString("PURPLE", comment: ""), color: .systemPurple),
        TintColor(key: "systemGreen", title: NSLocalizedString("GREEN", comment: ""), color: .systemGreen),
        TintColor(key: "systemYellow", title: NSLocalizedString("YELLOW", comment: ""), color: .systemYellow),
        TintColor(key: "systemOrange", title: NSLocalizedString("ORANGE", comment: ""), color: .systemOrange),
        TintColor(key: "systemPink", title: NSLocalizedString("PINK", comment: ""), color: .systemPink),
        TintColor(key: "systemRed", title: NSLocalizedString("RED", comment: ""), color: .systemRed)
    ]

    init() {
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("TINT_COLOR", comment: "")

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}

// MARK: - Table View Data Source
extension SettingsTintColorViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tintColors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultTintColor = UserDefaults.standard.string(forKey: "General.tintColor") ?? "systemBlue"
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "TintColorCell")
        let tintColor = tintColors[indexPath.row]
        cell.textLabel?.text = tintColor.title
        cell.imageView?.image = UIImage(systemName: "circle.fill")
        cell.imageView?.tintColor = tintColor.color
        if defaultTintColor == tintColor.key {
            cell.accessoryType = .checkmark
            self.checkedIndexPath = indexPath
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tintColor = tintColors[indexPath.row]
        if let checkedIndexPath = self.checkedIndexPath {
            if checkedIndexPath != indexPath {
                tableView.cellForRow(at: checkedIndexPath)?.accessoryType = .none
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.checkedIndexPath = indexPath
                self.view.window?.tintColor = tintColor.color
                UserDefaults.standard.set(tintColor.key, forKey: "General.tintColor")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
