//
//  ProfileViewController.swift
//  Media Project
//
//  Created by JinwooLee on 2/10/24.
//

import UIKit

final class ProfileViewController: BaseViewController {

    let mainView = ProfileView()
    let profileSettingList = ["이름", "사용자 이름", "성별", "소개", "링크"]
    var profileSettingDataList = ["이름", "사용자 이름", "성별", "소개", "링크"]

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        mainView.settingTableView.reloadData()
        print(#function)
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.settingTableView.delegate = self
        mainView.settingTableView.dataSource = self

    }
    
    override func configureNavigation() {
        super.configureNavigation()
        
        navigationItem.title = "프로필 설정"
        navigationItem.rightBarButtonItem = nil
    }
}


extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Label_TextfieldTableViewCell.identifier, for: indexPath) as! Label_TextfieldTableViewCell
        
        cell.titleLabel.text = profileSettingList[indexPath.row]
        cell.titleTextField.placeholder = profileSettingDataList[indexPath.row]
        cell.titleTextField.setPlaceholderColor(.systemGray)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? Label_TextfieldTableViewCell else {
            return
        }
        
        let vc = ProfileDetailViewController()
        vc.placeHolder = profileSettingDataList[indexPath.row]
        vc.textField.text = currentCell.titleTextField.text
        vc.nicknameSpace = { value in
            print("안녕하세요")
            print(value)
            currentCell.titleTextField.text = value
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
}
