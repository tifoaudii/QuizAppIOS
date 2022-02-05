//
//  UITableViewExtensions.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 05/02/22.
//

import UIKit

extension UITableView {
    
    func registerCell(for type: UITableViewCell.Type) {
        let className: String = String(describing: type)
        register(.init(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(for type: T.Type) -> T? {
        let className: String = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}
