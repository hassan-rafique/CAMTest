//
//  Alert.swift
//  CAMTest
//
//  Created by Hassan Rafique Awan on 06/05/2020.
//  Copyright © 2020 Hassan Rafique Awan. All rights reserved.
//

import Foundation

import UIKit

struct AlertAction {
    let buttonTitle: String
    let handler: (() -> Void)?
}

struct SingleButtonAlert {
    let title: String
    let message: String?
    let action: AlertAction
}
