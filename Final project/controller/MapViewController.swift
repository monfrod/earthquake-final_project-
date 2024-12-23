//  ViewController.swift
//  Final project
//
//  Created by yunus on 14.12.2024.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var earthquakeData: EarthquakeResponse?
    let locationManager = CLLocationManager()
    let earthquakeManager = AFManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        DispatchQueue.global(qos: .background).async {
            self.earthquakeManager.fetchEartquake { result in
                DispatchQueue.main.async {
                    self.earthquakeData = result
                    if let earthquakeData = self.earthquakeData {
                        for feature in earthquakeData.features {
                            let properties = feature.properties
                            let coordinates = feature.geometry.coordinates
                            let magnitude = properties.mag
                            let title = properties.place
                            
                            let pin = MKPointAnnotation()
                            pin.coordinate = CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
                            pin.title = title
                            pin.subtitle = "Magnitude: \(magnitude ?? 0.0)"
                            self.mapView.addAnnotation(pin)
                        }
                    }
                }
            }
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
    }


}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
}

