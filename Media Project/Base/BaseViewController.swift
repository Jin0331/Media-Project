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
        configureNavigation ()
    }
    
    func configureHirerachy() {
        print(#function, "base")
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        print(#function, "base")
    }
    
    func configureNavigation () {
        // background color
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .black
        
        // font setting
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25, weight: .heavy)
        ]
        navigationItem.title = "고래밥님"

    }
}

