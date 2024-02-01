//
//  TrendTVModel.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import Foundation

struct TVTrendModel : Decodable {
    let results : [TrendTV]
}

struct TrendTV : Decodable {
    let adult : Bool
    let backdropPath : String
    let id : Int
    let name : String?
    let originalName : String?
    let overview : String
    let posterPath : String
    let voteAverage : Double
    let voteCount : Int
    
    enum CodingKeys : String, CodingKey {
        case adult, id, name, overview
        case backdropPath = "backdrop_path"
        case originalName = "original_name"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
