//
//  StateDetailCoordinator.swift
//  CAMTest
//
//  Created by Hassan Rafique Awan on 06/05/2020.
//  Copyright © 2020 Hassan Rafique Awan. All rights reserved.
//

import UIKit

class StateDetailCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let state: State
    
    init(presenter: UINavigationController,
         state: State) {
        self.state = state
        self.presenter = presenter
    }
    
    func start() {
        let controller = StateDetailViewController()
        controller.state = state
        presenter.pushViewController(controller, animated: true)
    }
}
