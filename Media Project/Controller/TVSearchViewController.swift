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
        
        
        print()
        
        MediaSessionManager.shared.configuration(api: MediaAPI.Configuration.countries) { (item : Countries?, error : MediaAPI.APIError?) in
            if error == nil {
                guard let item = item else { return }
                
                dump(item)
            } else {
                dump(error)
            }
        }
        
    }
    
    
    
    
    override func configureNavigation() {
        super.configureNavigation()
        navigationItem.title = "찾기"
    }

}


