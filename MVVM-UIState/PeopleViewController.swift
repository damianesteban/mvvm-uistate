//
//  PeopleViewController.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UIStateDelegate {

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    var viewModel: NotesViewViewModel?
    //let errorView: ErrorView = .fromNib()
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    var state: UIState = .loading {
        didSet {
            update(state: state)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewAppearance()
        viewModel?.delegate = self
        viewModel?.fetchObjects(for: Swapi.people) { _ in print("ViewModel fetched") }
    }

    func update(state newState: UIState) {
        print("Updating state.....")
        switch newState {
        case .loading:
            printState(state: state)
            loadingView()
        case .success:
            printState(state: state)
            viewForSuccess()
        case .failure(_):
            printState(state: state)
            viewForFailure()
        }
    }

    func printState(state: UIState) {
        print("Did update state to: \(state)")
    }

    func loadingView() {
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }

    func viewForSuccess() {
        activityIndicatorView.stopAnimating()
        tableView.reloadData()
    }

    func viewForFailure() {
        activityIndicatorView.stopAnimating()
        //view.addSubview(errorView)
    }
}

// MARK: UITableViewDataSource Methods
extension NotesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            fatalError("No cell available for reuse")
        }

        if let cellViewModel = viewModel?.viewModel(for: indexPath.row) {
            cell.textLabel?.text = cellViewModel.title
            cell.detailTextLabel?.text = cellViewModel.detail
        }
        return cell
    }
}

extension NotesViewController {
    func configureViewAppearance() {
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        activityIndicatorView.color = .blue
    }
}
