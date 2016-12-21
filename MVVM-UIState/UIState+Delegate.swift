//
//  UIState+Delegate.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation

enum UIState {
    case loading
    case success
    case failure(Error)
}

protocol UIStateDelegate: class {
    var state: UIState { get set }
}

protocol UIStateHandler {
    var delegate: UIStateDelegate? { get set }
}
