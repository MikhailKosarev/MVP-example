//
//  ViewController.swift
//  MVP-example
//
//  Created by Mikhail on 21.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Declare UI elements
    private let usersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setDelegates()
        setConstraints()
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(usersTableView)
        usersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setDelegates() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            usersTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            usersTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "cell \(indexPath.row)"
        return cell
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDelegate {
    
}

