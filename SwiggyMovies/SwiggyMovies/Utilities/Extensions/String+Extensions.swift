//
//  String+Extensions.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation

extension String {
  public static func stringFromClass(_ anyClass : AnyClass) -> String {
    let string = NSStringFromClass(anyClass)
    return string.components(separatedBy: ".").last!
  }
}
