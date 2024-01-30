//
//  TVSeriesListsModel.swift
//  Media Project
//
//  Created by JinwooLee on 1/30/24.
//

import Foundation

struct TVSeriesListsModel : Decodable {
    let page : Int
    let results : [TVSeriesLists]
    let totalPages : Int
    
    enum CodingKeys : String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

struct TVSeriesLists : Decodable {
    let adult : Bool
    let backdropPath : String?
    let id : Int
    let name : String
    let originalName : String
    let overview : String
    let posterPath : String?
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
