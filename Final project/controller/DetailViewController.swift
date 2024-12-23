//
//  DetailViewController.swift
//  Final project
//
//  Created by yunus on 15.12.2024.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var magnitudeLabel: UILabel!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    var pinCoordinateLong: Double = 0
    var pinCoordinateLat: Double = 0
    
    var titleText: String = ""
    var magnitude: Double = 0.0
    var depth: Double = 0.0
    var date: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI
        titleLabel.text = titleText
        
        let formattedMagnitude = String(format: "%.1f", magnitude)
        magnitudeLabel.text = "Magnitude: \(formattedMagnitude)"
        
        let formattedDepth = String(format: "%.2f", depth)
        depthLabel.text = "Depth \(formattedDepth) km"
        
        let formattedDate = setFormattedData(milisecond: date)
        dateLabel.text = "Date: \(formattedDate)"
        
        
        //MapKit
        let coordinate = CLLocationCoordinate2D(latitude: pinCoordinateLat, longitude: pinCoordinateLong)
        let span = MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        self.mapView.addAnnotation(pin)
        
    }
    
    func setFormattedData(milisecond: Double) -> String{
        let timestampMilliseconds = milisecond
        let timestampSeconds = TimeInterval(timestampMilliseconds) / 1000
        let date = Date(timeIntervalSince1970: timestampSeconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
