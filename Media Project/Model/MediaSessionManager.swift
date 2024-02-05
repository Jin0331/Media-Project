//
//  MediaSessionManager.swift
//  Media Project
//
//  Created by JinwooLee on 2/5/24.
//

import UIKit
import Alamofire

class MediaSessionManager {
    
    static let shared = MediaSessionManager()
    
    private init () {}
       
    //TODO: - Configuration URL세션으로 구성
    func configuration<T: Decodable>(api : MediaAPI.Configuration, completionHandler : @escaping (T?, MediaAPI.APIError?) -> Void) {
        var url = URLRequest(url: api.endPoint)
        url.httpMethod = "GET"
        url.addValue(API.TMDBAPI, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completionHandler(nil, .failedRequeset)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completionHandler(nil, .invalidData)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    completionHandler(nil, .invalidDecodable)
                }
            }
        }.resume()
    }
    
    //TODO: - AF에서 URLSession으로 변경
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
