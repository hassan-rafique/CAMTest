//
//  StatesListViewModel.swift
//  CAMTest
//
//  Created by Hassan Rafique Awan on 06/05/2020.
//  Copyright © 2020 Hassan Rafique Awan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StatesListViewModel {

    let states: BehaviorRelay<[State]> = BehaviorRelay(value: [])
    let onShowError = PublishSubject<SingleButtonAlert>()

    private let disposeBag = DisposeBag()
    private let serverClient = ServerClient()
    private let loadInProgress = BehaviorRelay(value: false)


    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress
            .asObservable()
            .distinctUntilChanged()
    }
    
    func getUSAStates() {
        loadInProgress.accept(true)

        serverClient
            .getStates()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [unowned self] states in
                    self.loadInProgress.accept(false)
                    guard states.count > 0 else {
                        self.states.accept([])
                        return
                    }
                    self.states.accept(states)
                },
                onError: { [unowned self] error in
                    self.loadInProgress.accept(false)
                    let okAlert = SingleButtonAlert(
                        title: error.localizedDescription,
                        message: nil,
                        action: AlertAction(buttonTitle: "OK", handler: { print("Ok pressed!") })
                    )
                    self.onShowError.onNext(okAlert)
                })
            .disposed(by: disposeBag)
    }
}


