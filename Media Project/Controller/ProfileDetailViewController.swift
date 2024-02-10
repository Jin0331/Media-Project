//
//  ProfileDetailViewController.swift
//  Media Project
//
//  Created by JinwooLee on 2/10/24.
//

import UIKit
import SnapKit
import Then

class ProfileDetailViewController: BaseViewController {

    var nicknameSpace : ( (String) -> Void)?
    var placeHolder = ""
    
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHirerachy() {
        view.addSubview(textField)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        textField.placeholder = placeHolder
        textField.textColor = .white
        textField.setPlaceholderColor(.systemGray)
    }
    
    override func configureNavigation() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .heavy)
        ]
        
        navigationItem.title = placeHolder + " 설정"
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action: #selector(profileButtonClicked))
        navigationItem.rightBarButtonItem = profileButton
    }

    @objc override func profileButtonClicked(_ sender : UIBarButtonItem) {
        nicknameSpace?(textField.text!)
        navigationController?.popViewController(animated: true)
    }
}

