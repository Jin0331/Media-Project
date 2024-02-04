//
//  BaseViewController.swift
//  Media Project
//
//  Created by JinwooLee on 1/31/24.
//

import UIKit

class BaseViewController: UIViewController{
    
    var tvID : Int = 0
    
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
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        // font setting
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25, weight: .heavy)
        ]
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        navigationItem.title = "고래밥님"
        
    }
}

extension BaseViewController {
    
    enum TransitionStyle {
        case present
        case presentNavigation // 네비게이션 임베드한 채로 present
        case presentFullNavigation // 네비게이션 임베드 된 full presesnt
        case push
    }
    
    func tvViewTransition<T:BaseViewController>(style : TransitionStyle, viewController : T.Type, tvID : Int) {
        let vc = T()
        vc.tvID = tvID
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(vc, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
