//
//  DayDetailsViewController.swift
//  Forecast_Codable
//
//  Created by Karl Pfister on 2/6/22.
//

import UIKit

class DayDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var dayForcastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHighLabel: UILabel!
    @IBOutlet weak var currentLowLabel: UILabel!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    
    //MARK: - Properties
    // Placeholder Property
    var days: [Day] = []
    var forecastData: TopLevelDictionary?
    
    //MARK: - View Lifecyle
    func setupTable(){
        dayForcastTableView.delegate = self
        dayForcastTableView.dataSource = self
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        /// Array assignment is using closure to pass in the data
        NetworkController.fetchDays { forecastData in
            /// Unwrap the property
            guard let forecastData = forecastData else { return }
            self.forecastData = forecastData
            self.days = forecastData.days
            /// Grand Central Dispatch responsible for concurrency
            DispatchQueue.main.async {
                /// Reference self when in closure
                self.updateViews()
            }
        }
    }
    
    // Helper Function:
    func updateViews() {
        let day = days[0]
        cityNameLabel.text = forecastData?.cityName
        currentTempLabel.text = "\(day.temp)F"
        currentHighLabel.text = "\(day.highTemp)F"
        currentLowLabel.text = "\(day.lowTemp)F"
        currentDescriptionLabel.text = day.weather.description
        // Because this is involved in updating views
        self.dayForcastTableView.reloadData()
    }
}

//MARK: - Extensions
extension DayDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as? DayForcastTableViewCell else {return UITableViewCell()}
        let day = days[indexPath.row]
        cell.updateViews(day: day)
        return cell
    }
}

