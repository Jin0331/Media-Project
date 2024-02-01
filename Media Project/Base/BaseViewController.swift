//
//  BaseViewController.swift
//  Media Project
//
//  Created by JinwooLee on 1/31/24.
//

import UIKit

class BaseViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black //TODO: - Style 통일화를 위한 Enum 필요함. 추후 구현
        
        configureHirerachy()
        configureLayout()
        configureView()
    }
    
    func configureHirerachy() {
        print(#function, "base")
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        print(#function, "base")
    }
}

