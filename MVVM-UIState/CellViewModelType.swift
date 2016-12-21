//
//  CellViewModelType.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation

protocol CellViewModelType {
    associatedtype ListItem
    var title: String { get }
    var detail: String { get }
}
