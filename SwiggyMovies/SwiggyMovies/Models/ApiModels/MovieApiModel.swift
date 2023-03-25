//
//  MovieApiModel.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

struct MovieApiModel: Codable {
  let imdbId: String?
  let title: String?
  let year: String?
  let type: String?
  let posterUrl: String?
  
  enum CodingKeys: String, CodingKey {
    case title = "Title"
    case year = "Year"
    case imdbId = "imdbID"
    case type = "Type"
    case posterUrl = "Poster"
  }
}

