//
//  StateDetailViewController.swift
//  CAMTest
//
//  Created by Hassan Rafique Awan on 06/05/2020.
//  Copyright © 2020 Hassan Rafique Awan. All rights reserved.
//

import UIKit
import MapKit


class StateDetailViewController: UIViewController {
    
    var state: State?
    
    private let mapView: MKMapView = {
        let view = MKMapView(frame: .zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        if let state = state {
            mapView.centerToLocation(CLLocation(latitude: state.lat, longitude: state.lon))
        }
    }
    
    private func setupView() {
        self.title = state?.state
        view.backgroundColor = .white
        view.addSubview(mapView)
        layoutView()
    }
    
    private func layoutView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK:- Map Setup
private extension MKMapView {
    
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 500000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
            latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
