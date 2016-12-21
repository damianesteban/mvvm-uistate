//
//  ListViewModelType.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation
// ListViewModel
protocol ListViewModelType {
    associatedtype CellViewModelType
    var numberOfItems: Int { get }
    func viewModel(for index: Int) -> CellViewModelType
}
