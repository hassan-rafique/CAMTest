//
//  StatesListViewController.swift
//  CAMTest
//
//  Created by Hassan Rafique Awan on 06/05/2020.
//  Copyright © 2020 Hassan Rafique Awan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit
import PKHUD

protocol StatesListViewControllerDelegate: class {
    func statesListViewControllerDidSelectState(_ state: State)
}

class StatesListViewController: UIViewController {

    weak var delegate: StatesListViewControllerDelegate?

    private let disposeBag = DisposeBag()
    private let viewModel = StatesListViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
        setupCellConfiguration()
        setupCellTapHandling()
        viewModel.getUSAStates()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        layoutView()
        tableView.register(StateTableViewCell.self, forCellReuseIdentifier: StateTableViewCell.identifier)
    }
    
    private func layoutView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setLoadingHud(visible: Bool) {
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        visible ? PKHUD.sharedHUD.show(onView: view) : PKHUD.sharedHUD.hide()
    }
}

//MARK:- Rx Setup
private extension StatesListViewController {

    private func bindViewModel() {
        viewModel
            .onShowLoadingHud
            .map { [unowned self] in self.setLoadingHud(visible: $0) }
            .subscribe()
            .disposed(by: disposeBag)
        
        viewModel
            .onShowError
            .map { [unowned self] in self.presentSingleButtonDialog(alert: $0)}
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func setupCellConfiguration() {
        viewModel.states
            .bind(to: tableView
                .rx
                .items(cellIdentifier: StateTableViewCell.identifier,
                       cellType: StateTableViewCell.self)) { row, state, cell in
                        cell.configureWithState(state: state)
        }
        .disposed(by: disposeBag)
    }
  
    private func setupCellTapHandling() {
        tableView
            .rx
            .modelSelected(State.self)
            .subscribe(onNext: { [unowned self] state in
                self.delegate?.statesListViewControllerDidSelectState(state)
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                } 
            })
            .disposed(by: disposeBag)
    }
}
