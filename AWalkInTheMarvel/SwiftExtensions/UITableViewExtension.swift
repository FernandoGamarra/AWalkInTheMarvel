//
//  UITableViewExtension.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 20/4/22.
//

import UIKit

extension UITableView {
    func deselectAllRows(animated: Bool) {
        guard let selectedRows = indexPathsForSelectedRows else { return }
        for indexPath in selectedRows { deselectRow(at: indexPath, animated: animated) }
    }
}
