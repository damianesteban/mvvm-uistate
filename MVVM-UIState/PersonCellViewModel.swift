//
//  PersonCellViewModel.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation


struct PersonCellViewModel: CellViewModelType {

    typealias ListItem = Person
    let person: Person

    var title: String {
        return "Title: \(person.name)"
    }

    var detail: String {
        return "Age: \(person.age)"
    }
}
