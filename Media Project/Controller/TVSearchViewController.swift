//
//  TVSearchViewController.swift
//  Media Project
//
//  Created by JinwooLee on 2/5/24.
//

import UIKit

class TVSearchViewController : BaseViewController {
    
    let mainView = TVSearchView()
    var countries : Countries?
    var genre : Genres?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        //MARK: - Configuration API request
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaSessionManager.shared.fetchURLSession(api: MediaAPI.Configuration.countries) { (item : Countries?, error : MediaAPI.APIError?) in
                if error == nil {
                    guard let item = item else { return }
                    self.countries = item
                } else {
                    dump(error)
                }
                group.leave()
            }
        }
        
        //MARK: - Genres API request
        group.enter()
        DispatchQueue.global().async(group: group) {
            MediaSessionManager.shared.fetchURLSession(api: MediaAPI.Configuration.countries) { (item : Countries?, error : MediaAPI.APIError?) in
                if error == nil {
                    guard let item = item else { return }
                    self.countries = item
                } else {
                    dump(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("갱신 완료")
            dump(self.countries)
        }
    }
    
    override func configureNavigation() {
        super.configureNavigation()
        navigationItem.title = "찾기"
    }

}


