//
//  MovieImageCachingUtility.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation
import UIKit

class MovieImageCachingUtility {
  
  static let instance = MovieImageCachingUtility()
  private let imageCache = NSCache<NSString, UIImage>()
  private let backgrondQueue = DispatchQueue(label: "image_chache_background_queue", qos: .background)
  
  private init() {  }
  
  private func imageForKey(_ key: NSString) -> UIImage? {
    return imageCache.object(forKey: key)
  }
  
  private func setImage(_ image: UIImage, forKey key: NSString) {
    imageCache.setObject(image, forKey: key)
  }
  
  public func loadImage(fromUrl url: URL, completion: @escaping (UIImage?) -> ()) {
    
    backgrondQueue.async {
      //check for image in cache
      let key = url.lastPathComponent as NSString
      
      if let image = self.imageForKey(key) {
        completion(image)
      } else {
        //load image from url
        do {
          let data = try Data(contentsOf: url)
          let image = UIImage(data: data)
          if let unwrappedImage = image {
            self.setImage(unwrappedImage, forKey: key)
          }
          completion(nil)
        } catch {
          //
          completion(nil)
        }
      }
    }
  }
}
