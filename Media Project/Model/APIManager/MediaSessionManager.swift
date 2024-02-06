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
       
    func fetchURLSession<T: Decodable>(api : MediaAPI.SearchDetail, completionHandler : @escaping (T?, MediaAPI.APIError?) -> Void) {
        
        print(api.parameter)
        
        // ✅ query 추가 !!! 이모지!?
        var urlComponents = URLComponents(string: api.endPoint.absoluteString)
        let queryItems = api.parameter.map { (key: String, value: Any) in
            
            if let value = value as? String {
                return URLQueryItem(name: key, value: value)
            } else {
                return URLQueryItem(name: key, value: "")
            }
        }
        urlComponents?.queryItems = queryItems
        
        var url = URLRequest(url: (urlComponents?.url)!)
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
    
    //MARK: - Search
    func fetchURLSession<T: Decodable>(api : MediaAPI.Search, completionHandler : @escaping (T?, MediaAPI.APIError?) -> Void) {
        
        // ✅ query 추가 !!! 이모지!?
        var urlComponents = URLComponents(string: api.endPoint.absoluteString)
        let queryItems = api.parameter.map { (key: String, value: Any) in
            
            if let value = value as? String {
                return URLQueryItem(name: key, value: value)
            } else {
                return URLQueryItem(name: key, value: "")
            }
        }
        print(queryItems)
        urlComponents?.queryItems = queryItems
        
        var url = URLRequest(url: (urlComponents?.url)!)
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
    
    //MARK: - TV
    func fetchURLSession<T: Decodable>(api : MediaAPI.TV, completionHandler : @escaping (T?, MediaAPI.APIError?) -> Void) {
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
    
    
    //MARK: - Trend
    func fetchURLSession<T: Decodable>(api : MediaAPI.Trend, completionHandler : @escaping (T?, MediaAPI.APIError?) -> Void) {
        // ✅ query 추가 !!! 이모지!?
        var urlComponents = URLComponents(string: api.endPoint.absoluteString)
        let queryItems = api.parameter.map { (key: String, value: Any) in
            
            if let value = value as? String {
                return URLQueryItem(name: key, value: value)
            } else {
                return URLQueryItem(name: key, value: "")
            }
        }
        urlComponents?.queryItems = queryItems
        
        var url = URLRequest(url: (urlComponents?.url)!)
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
}
