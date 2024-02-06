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
    
    var countries : Countries?
    var genres : Genres?
    
    //    var dataList : [String : Decodable] = [:] //TODO: - String을 관리하는 Enum이 필요할까?? ❓
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.mainTableView.dataSource = self
        mainView.mainTableView.delegate = self
        
        mainView.searchBar.delegate = self
        hideKeyboardWhenTappedAround() // 키보드 숨기기
        
        let group = DispatchGroup()
        
        //MARK: - Configuration API request
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaSessionManager.shared.fetchURLSession(api: MediaAPI.Search.countries) { (item : Countries?, error : MediaAPI.APIError?) in
                if error == nil {
                    guard let item = item else { return }
                    self.countries = item
                    //                    self.dataList["countries"] = item
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
                    self.genres = item
//                    self.dataList["genres"] = item
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

//TODO: - row의 수를 1개로 하고, Section을 나누어서 해보자. 더 간단할 듯? -> 크게 다르지 않은듯?
extension TVSearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVSearchTableViewCell.identifier, for: indexPath) as! TVSearchTableViewCell
        let searchKey = MediaAPI.Search.searchByIndex(value: indexPath.section)
        
        cell.titleLabel.text = searchKey.titleValue
        cell.subCollectionView.delegate = self
        cell.subCollectionView.dataSource = self
        cell.subCollectionView.layer.name = searchKey.caseValue
        cell.subCollectionView.reloadData()
        
        return cell
    }
}


extension TVSearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(#function)
        //MARK: - Dictionary를 사용해서 데이터를 한번에 처리하면, 복잡해진다.;;; 일단 끝까지 해보자 -> 일단포기,, Optional Binding에서 하나의 분기가 끝나면 return되므로, 2가지 동시표현 불가능한 듯.
        return collectionView.layer.name! == MediaAPI.Search.countries.caseValue ? countries?.count ?? 0 : genres?.genres.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as! CommonCollectionViewCell

        if collectionView.layer.name! == MediaAPI.Search.countries.caseValue {
            if let countries {
                cell.titleLabel.text = countries[indexPath.row].nativeName
            }
        } else {
            if let genres {
                cell.titleLabel.text = genres.genres[indexPath.row].name
            }
        }
        
        return cell
    }
    
    
    //TODO: - genreID, countryID 2가지의 경우.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView.layer.name! == MediaAPI.Search.countries.caseValue {
            ViewTransition(style: .push, viewControllerType: CommonCollectionViewController.self, countryID: countries?[indexPath.row].iso_3166_1 ?? "")
            print("country 호출")
            print(countries?[indexPath.row].iso_3166_1 ?? "")
        } else {
            ViewTransition(style: .push, viewControllerType: CommonCollectionViewController.self, genreID: genres?.genres[indexPath.row].id ?? 0)
            print("genre 호출")
            print(genres?.genres[indexPath.row].id ?? 0)
        }
    }
}


//TODO: - 서치 진행했을 때,검색결과 아래에 나타나도록
extension TVSearchViewController : UISearchBarDelegate {
    
}
