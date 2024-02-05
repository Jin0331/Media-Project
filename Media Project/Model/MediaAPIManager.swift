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
        
    //MARK: - API Requet Function
    //TODO: - generic 적용 - 완
    func fetchTrend<T : Decodable>(api : MediaAPI.Trend, completionHandler : @escaping (T) -> Void) {
        
        AF.request(api.endPoint,
                   method: MediaAPI.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: MediaAPI.header)
        .responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTV<T : Decodable>(api : MediaAPI.TV, completionHandler : @escaping (T) -> Void) {
        
        AF.request(api.endPoint,
                   method: MediaAPI.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: MediaAPI.header)
        .responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let success):
                print("조회 성공")
                
                completionHandler(success)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
