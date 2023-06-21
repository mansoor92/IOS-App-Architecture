//
//  PublicApi.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 21/06/2023.
//

import UIKit
import Reusable
import Data

class DomainViewComposer {
    
    static func compose(repository: DomainRepository) -> DomainViewController {
        let view = DomainViewController.instantiate()
        let viewModel = DomainViewModel(repository: repository, view: view)
        view.viewModel = viewModel
        return view
    }
}

class DomainViewController: BaseViewController, StoryboardSceneBased {
    
    static var sceneStoryboard = UIStoryboard.domain()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let cellReuseIdentifier = "cell"
    var viewModel: DomainViewModel!
    weak var delegate: WebPageDelegate?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadDomains()
    }
    
    // MARK: UI
    private func configureView() {
        navigationItem.title = "Domains"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = 32
        tableView.addSpinner(target: self, action: #selector(onRefresh))
    }
    
    // MARK: - Actions
    @objc private func onRefresh() {
        loadDomains(forceRefresh: true)
    }
    
    private func loadDomains(forceRefresh: Bool = false) {
        tableView.showSpinner()
        viewModel.loadDomains(forceRefresh: forceRefresh)
    }
}

extension DomainViewController: DomainViewModelOutput {
    
    func domainsLoaded() {
        tableView.hideSpinner()
        tableView.reloadData()
    }
    
    func show(error: Error) {
        tableView.hideSpinner()
        view.show(message: error.localizedDescription)
    }
}

extension DomainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let item = viewModel.item(position: indexPath.row)
//        cell.largeContentTitle = item.api
        cell.textLabel?.text = item.api
        cell.detailTextLabel?.text = item.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.item(position: indexPath.row)
        guard let url = URL(string: item.link) else {
            view.show(message: "Invalid Link")
            return
        }
        delegate?.show(self, url: url)
    }
}



