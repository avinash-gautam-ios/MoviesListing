//
//  HttpManager.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

typealias RequestParams = [String: Any]
typealias RequestStatusCode = Int

enum HttpManagerError: Error {
  case notSuccessCode
  case reponseDataEmpty
  case parsingFailed
}

struct HttpManager {
  
  static func httpRequest<T: Decodable>(type: HTTPRequestType,
                             params: RequestParams? = nil,
                             url: URL,
                             completion: @escaping (T?, Error?) -> ()) {
    
    var httpRequest = URLRequest(url: url)
    httpRequest.httpMethod = type.rawValue
    httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let urlSession = URLSession.shared
    let dataTask = urlSession.dataTask(with: httpRequest) { (responseData, urlResponse, error) in
      
      //check for 200 success code
      guard
        let httpURLResponse = urlResponse as? HTTPURLResponse,
        httpURLResponse.statusCode == 200 else {
        return completion(nil, HttpManagerError.notSuccessCode)
      }
      
      //check for response
      guard let response = responseData else {
        return completion(nil, HttpManagerError.reponseDataEmpty)
      }
      
      do {
        let jsonDecoder = JSONDecoder()
        let responseModel = try jsonDecoder.decode(T.self, from: response)
        completion(responseModel, nil)
      } catch let parsingError {
        print(":parsing error for \(T.self) = \(parsingError.localizedDescription)")
        completion(nil, HttpManagerError.parsingFailed)
      }
    }
    dataTask.resume()
  }
  
}
