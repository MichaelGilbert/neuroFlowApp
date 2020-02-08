//
//  PlayerDetailViewController.swift
//  NeuroFlowProject
//
//  Created by Michael Gilbert on 2/7/20.
//  Copyright © 2020 Michael Gilbert. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var details: SecondViewController.Person?
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let details = details else { return }
        
        playerName.text = details.name
        score.text = "\(details.score ?? 0)"
        if let dateCreated = details.date_created {
            dateLabel.text = convertDateToString(dateCreated)
        } else {
            dateLabel.text = "Invalid Date"
        }
    }
    
    func convertDateToString(_ dateCreated: Double) -> String
    {
        let epochTime = TimeInterval(dateCreated) / 1000
        let unixTime = NSDate(timeIntervalSince1970: epochTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone() as TimeZone
        
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: unixTime as Date)
        return dateString
    }
}
