//
//  ProfileViewController.swift
//  Media Project
//
//  Created by JinwooLee on 2/10/24.
//

import UIKit

final class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureNavigation() {
        super.configureNavigation()
        
        navigationItem.title = "프로필 설정"
        navigationItem.rightBarButtonItem = nil
    }
    

}
