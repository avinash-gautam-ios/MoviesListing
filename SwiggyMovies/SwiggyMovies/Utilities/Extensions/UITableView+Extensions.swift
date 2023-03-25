//
//  UITableView+Extensions.swift
//  SwiggyMovies
//
//  Created by Avinash Gautam on 27/04/19.
//  Copyright © 2019 Avinash Gautam. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
  
  public func register<T>(_ anyClass : T.Type, bundle : Bundle) -> Void where T : UITableViewCell {
    self.register(UINib(nibName: String.stringFromClass(anyClass), bundle: bundle), forCellReuseIdentifier: String.stringFromClass(anyClass))
  }
  
  public func registerCells<T>(_ cells : [T.Type], bundle : Bundle) -> Void where T : UITableViewCell {
    for cellClass in cells {
      self.register(cellClass, bundle:bundle)
    }
  }
}
