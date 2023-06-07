//
//  ViewController.swift
//  TestApp
//
//  Created by Irshad Ahmad on 07/06/23.
//

import UIKit
import Combine

final class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let viewModel: ViewModel
    private var cancellables = Set<AnyCancellable>()
    
    required init(with viewModel: ViewModel = .init()) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        observePublishers()
    }

    private func setupView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
    }
    
    private func observePublishers() {
        viewModel.refreshView.sink { shouldRefresh in
            if shouldRefresh {
                self.refreshView()
            }
        }.store(in: &cancellables)
    }
    
    private func refreshView() {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = viewModel.jokes[indexPath.row]
        return cell
    }
}
