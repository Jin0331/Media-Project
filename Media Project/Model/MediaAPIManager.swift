//
//  MediaAPIManager.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import UIKit
import Alamofire

class MediaAPIManager {
    static let shared = MediaAPIManager()
    
    private init () { }
    
    enum TVSeries: String {
        case top_rated
        case popular
    }
    
    
    func fetchTrendingTV(completionHandler : @escaping (([TrendTV]) -> Void)) {
        let url = "https://api.themoviedb.org/3/trending/tv/week?language=ko-KR"
        
        //TODO: - API.swift로 변경해야됨 - 완료
        let header : HTTPHeaders = ["Authorization" : API.TMDBAPI]
        
        // 비동기 처리
        AF.request(url, method: .get, headers: header).responseDecodable(of: TrendTVModel.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success.results)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    //TODO: - Top Rate과 Popular는 url이 유사하므로, 매개변수를 받아서 사용하고, pagination 적용
    func fetchTVSeriesLists(contents : String, page : Int, completionHandler : @escaping ([TVSeriesLists]) -> Void){
        let url = "https://api.themoviedb.org/3/tv/\(contents)?language=ko-KR&page=\(page)"
        
        print(url)
        
        let header : HTTPHeaders = ["Authorization" : API.TMDBAPI]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: TVSeriesListsModel.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success.results)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
