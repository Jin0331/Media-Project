//
//  Protocol.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import Foundation

protocol ViewSetUp {
    func configureHirerachy ()
    func configureLayout()
    func configureView()
}

protocol ResuableProtocol {
    static var identifier : String { get }
    var identifier_ : String{ get }
}
