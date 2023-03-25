//
//  URLTypes.swift
//  ToggleUsers
//
//  Created by Avinash Gautam on 23/03/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

enum URLType {
  private static let baseUrl = "http://www.omdbapi.com/"
  
  case search(key: String, pageNumber: Int)
  
  var url: String {
    switch self {
    case .search(key: let searchKey, pageNumber: let pageNumber):
      return URLType.baseUrl + "?apikey=\(AppKeys.omdbApiKey.rawValue)&s=\(searchKey)&page=\(String(pageNumber))"
    }
  }
  
}

