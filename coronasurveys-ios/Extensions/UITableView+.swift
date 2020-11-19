//
//  UITableView+.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 19/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

extension UITableView {
    // MARK: Register cells

    func register<R: CellIdentifier & UITableViewCell>(cell: R.Type) {
        register(R.self, forCellReuseIdentifier: R.identifier)
    }

    func register<R: CellIdentifier & UITableViewHeaderFooterView>(header: R.Type) {
        register(R.self, forHeaderFooterViewReuseIdentifier: R.identifier)
    }

    func register<R: CellIdentifier & UITableViewHeaderFooterView>(footer: R.Type) {
        register(R.self, forHeaderFooterViewReuseIdentifier: R.identifier)
    }

    // MARK: Dequeue cells

    func dequeue<R: CellIdentifier & UITableViewCell>(cell: R.Type, at indexPath: IndexPath) -> R {
        if let cell = dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? R {
            return cell
        } else {
            fatalError("A cell must be always dequeueable \(cell)")
        }
    }

    func dequeue<R: CellIdentifier & UITableViewHeaderFooterView>(header: R.Type) -> R {
        if let cell = dequeueReusableHeaderFooterView(withIdentifier: R.identifier) as? R {
            return cell
        } else {
            fatalError("A header must be always dequeueable \(header)")
        }
    }

    func dequeue<R: CellIdentifier & UITableViewHeaderFooterView>(footer: R.Type) -> R {
        if let cell = dequeueReusableHeaderFooterView(withIdentifier: R.identifier) as? R {
            return cell
        } else {
            fatalError("A footeer must be always dequeueable \(footer)")
        }
    }
}
