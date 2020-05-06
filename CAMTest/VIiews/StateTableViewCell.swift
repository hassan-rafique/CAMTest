//
//  StateTableViewCell.swift
//  CAMTest
//
//  Created by Hassan Rafique Awan on 06/05/2020.
//  Copyright © 2020 Hassan Rafique Awan. All rights reserved.
//

import UIKit

class StateTableViewCell: UITableViewCell {
    static let identifier = "StateTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithState(state: State) {
        self.textLabel?.text = state.state
        self.detailTextLabel?.text = state.city
    }
}
