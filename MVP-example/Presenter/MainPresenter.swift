//
//  MainPresenter.swift
//  MVP-example
//
//  Created by Mikhail on 21.09.2022.
//

import UIKit

/// an input protocol
protocol MainViewProtocol: UIViewController {
    func addUser(_ user: User)
    func deleteUser(withIndex index: Int)
}

/// an output protocol
protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol)
    
    func addUser(firstName: String, lastName: String)
    func deleteUser(withIndex index: Int)
}

/// presenter class
class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol?
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func addUser(firstName: String, lastName: String) {
        let user = User(firstName: firstName, lastName: lastName)
        view?.addUser(user)
    }
    
    func deleteUser(withIndex index: Int) {
        view?.deleteUser(withIndex: index)
    }
}
