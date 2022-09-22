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
    
    // MARK: - Private properties
    private var usersArray = [User]()
    
    // MARK: - Public properties
    ///declare presenter with a strong reference
    public var presenter: MainPresenterProtocol?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setDelegates()
        setConstraints()
    }
    
    // MARK: - Private methods
    private func setupView() {
        title  = "Users"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
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
    
    @objc private func addButtonTapped() {
        let alert = UIAlertController(title: "Add user", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            let firstName = alert.textFields?.first?.text
            let lastName = alert.textFields?[1].text
            self?.presenter?.addUser(firstName: firstName ?? "noFirstName",
                                     lastName: lastName ?? "NoLastName")
        }
        alert.addTextField()
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        self.present(alert, animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    func addUser(_ user: User) {
        usersArray.append(user)
        usersTableView.reloadData()
    }
    
    func deleteUser(withIndex index: Int) {
        usersArray.remove(at: index)
        usersTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = usersArray[indexPath.row].firstName + " " + usersArray[indexPath.row].lastName
        return cell
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            self?.presenter?.deleteUser(withIndex: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

