//
//  ServerClient.swift
//  CAMTest
//
//  Created by Hassan Rafique Awan on 06/05/2020.
//  Copyright © 2020 Hassan Rafique Awan. All rights reserved.
//

import Foundation
import RxSwift

class ServerClient {
    
    func getStates() -> Observable<[State]> {
        return Observable.create { observer -> Disposable in
            
            let url = URL(string: "https://raw.githubusercontent.com/vega/vega/master/docs/data/us-state-capitals.json")!
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    if let error = error {
                        observer.onError(error)
                    } else {
                        observer.onNext([])
                    }
                    return
                }
                
                do {
                    let states = try JSONDecoder().decode([State].self, from: data)
                    observer.onNext(states)
                } catch {
                    observer.onError(error)
                }
            }.resume()
            return Disposables.create()
        }
    }
}
