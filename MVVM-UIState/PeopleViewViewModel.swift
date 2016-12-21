//
//  PeopleViewViewModel.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation

/** TODO:
 1. Refactor viewModel to provide similar functionality as VM in Cloudy
 2. Refactor "" Functional Core Reactive Shell
 3. Refactor to use combination of "handler", ViewModel and Presenter (look at mvc repo)
 */
class NotesViewViewModel: ListViewModelType, UIStateHandler {

    typealias CellViewModelType = PersonCellViewModel
    private let service: NetworkService
    var delegate: UIStateDelegate?

    private lazy var people = [Person]()

    var numberOfItems: Int {
        return people.count
    }

    init(service: NetworkService = NetworkService()) {
        self.service = service
    }

    func viewModel(for index: Int) -> PersonCellViewModel {
        return PersonCellViewModel(person: people[index])
    }

    func fetchObjects(for resource: Resource, completion: @escaping (Void) -> Void) {
        service.fetchData(for: resource) { (resultData: Result<Data>) in
            let result = resultData
                .flatMap(f: jsonObject)
                .flatMap(f: parseObjectToDictionary)
                .flatMap(f: parseJSONArray)
            do {
                let jsonArray = try result.resolve()
                self.people = try jsonArray.flatMap { try Person(jsonRepresentation: $0) }
            } catch {
                print(error)
            }
        }

    }
}


