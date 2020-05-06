//
//  StatesListCoordinator.swift
//  CAMTest
//
//  Created by Hassan Rafique Awan on 06/05/2020.
//  Copyright © 2020 Hassan Rafique Awan. All rights reserved.
//

import UIKit

class StatesListCoordinator: Coordinator {
   
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let statesListController = StatesListViewController()
        statesListController.title = "States list"
        statesListController.delegate = self
        presenter.pushViewController(statesListController, animated: true)
    }
}


// MARK: - StatesListViewControllerDelegate
extension StatesListCoordinator: StatesListViewControllerDelegate {
    
    func statesListViewControllerDidSelectState(_ state: State) {
        let stateDetailCoordinator = StateDetailCoordinator(presenter: presenter, state: state)
        stateDetailCoordinator.start()
    }
}
