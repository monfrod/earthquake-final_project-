//
//  ViewController.swift
//  Final project
//
//  Created by yunus on 14.12.2024.
//

import UIKit

class RecentViewController: UIViewController {
  
    var earthquakeData: EarthquakeResponse?
    let earthquakeManager = AFManager()
 
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        DispatchQueue.global(qos: .background).async {
            self.earthquakeManager.fetchEartquake { result in
                DispatchQueue.main.async {
                    self.earthquakeData = result
                    self.tableView.reloadData()
                }
            }
        }
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

    @IBAction func GoInstructionButton(_ sender: Any) {
        view.window?.rootViewController = OnboardingViewController()
    }
    
}


extension RecentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthquakeData?.features.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecentTableViewCell
        if let data = earthquakeData?.features[indexPath.row] {
            
            let formattedDate = setFormattedData(milisecond: data.properties.time)
            let formattedMagnitude = String(format: "%.1f", data.properties.mag!)
            
            
            
            cell.titleLabel.text = data.properties.place
            cell.magnitudeLabel.text = formattedMagnitude
            cell.timeLabel.text = formattedDate
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if let data = earthquakeData?.features[indexPath.row] {
            vc.titleText = data.properties.title!
            vc.depth = data.geometry.coordinates[2]
            vc.magnitude = data.properties.mag!
            vc.date = data.properties.time
            vc.pinCoordinateLat = data.geometry.coordinates[1]
            vc.pinCoordinateLong = data.geometry.coordinates[0]
            
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

