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
    var profileSettingDataList = ["이름", "사용자 이름", "성별", "소개", "링크"] {
        didSet {
            mainView.settingTableView.reloadData()
        }
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
    
    
}
