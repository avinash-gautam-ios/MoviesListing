//
//  MovieSearchResults.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

struct MovieSearchResultApiModel: Codable {
  let movies: [MovieApiModel]?
  
  enum CodingKeys: String, CodingKey {
    case movies = "Search"
  }
}
