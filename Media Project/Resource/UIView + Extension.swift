//
//  UICollectionViewCell + Extension.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import UIKit

extension UIView : ResuableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    var identifier_: String {
        return String(describing: type(of: self))
    }
}
