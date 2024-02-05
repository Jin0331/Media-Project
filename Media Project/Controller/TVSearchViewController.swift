//
//  TVSearchViewController.swift
//  Media Project
//
//  Created by JinwooLee on 2/5/24.
//

import UIKit

class TVSearchViewController : BaseViewController {
    
    // View class로부터 데이터 끌어와서 사용
    let mainView = TVSearchView()
        
//    var countries : Countries?
//    var genres : Genres?
    
    var dataList : [String : Decodable] = [:] //TODO: - String을 관리하는 Enum이 필요할까?? ❓
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.mainTableView.dataSource = self
        mainView.mainTableView.delegate = self
        
        let group = DispatchGroup()
        
        //MARK: - Configuration API request
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaSessionManager.shared.fetchURLSession(api: MediaAPI.Search.countries) { (item : Countries?, error : MediaAPI.APIError?) in
                if error == nil {
                    guard let item = item else { return }
//                    self.countries = item
                    self.dataList["countries"] = item
                } else {
                    dump(error)
                }
                group.leave()
            }
        }
        
        //MARK: - Genres API request
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaSessionManager.shared.fetchURLSession(api: MediaAPI.Search.tv) { (item : Genres?, error : MediaAPI.APIError?) in
                if error == nil {
                    guard let item = item else { return }
//                    self.genres = item
                    self.dataList["genres"] = item
                } else {
                    dump(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("갱신 완료")
            self.mainView.mainTableView.reloadData()
        }
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        navigationItem.title = "찾기"
    }

}

//TODO: - row의 수를 1개로 하고, Section을 나누어서 해보자. 더 간단할 듯?
extension TVSearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVSearchTableViewCell.identifier, for: indexPath) as! TVSearchTableViewCell
        let searchKey = MediaAPI.Search.searchByIndex(value: indexPath.section)
        let item = dataList[searchKey.caseValue]
        
        cell.titleLabel.text = searchKey.titleValue
        
        
        return cell
    }
    
    
}
