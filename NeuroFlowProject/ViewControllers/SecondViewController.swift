//
//  SecondViewController.swift
//  NeuroFlowProject
//
//  Created by Michael Gilbert on 2/6/20.
//  Copyright © 2020 Michael Gilbert. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    let cellHeight: CGFloat = 88
    let headerHeight: CGFloat = 60

    @IBOutlet weak var scoresTableView: UITableView!
    var scoreData: NSMutableArray?
    
    struct Groups: Codable {
        let males: [Person]?
        let females: [Person]?
    }
    
    struct Person: Codable {
        let name: String?
        let score: Int?
        let date_created: Double?
    }
    
    var selectedPerson: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scoreNib = UINib(nibName: "PersonCell", bundle: nil)
        let headerNib = UINib(nibName: "SectionHeaderView", bundle: nil)
        scoresTableView.register(scoreNib, forCellReuseIdentifier: "scoreCell")
        scoresTableView.register(headerNib, forCellReuseIdentifier: "sectionHeader")
        getData()
    }
    
    func getData() {
        let urlString = "https://gist.githubusercontent.com/ryanneuroflow/370d19311602c091928300edd7a40f66/raw/1865ae6004142553d8a6c6ba79ccb511028a2cba/names.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let scores = try JSONDecoder().decode([Groups].self, from: data)
                   
                    let tempArray: NSMutableArray = []
                    for p: SecondViewController.Groups in scores {
                        if p.males != nil {
                            tempArray.add(p.males!)
                        }
                        if p.females != nil {
                            tempArray.add(p.females!)
                        }
                    }
                    self.scoreData = tempArray
                    
                    DispatchQueue.main.async {
                        self.scoresTableView.reloadData()
                    }
                    
                } catch let error {
                    print ("error: \(error)")
                }
            } else {
                print("No Data")
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlayerDetailViewController{
            destination.details = selectedPerson
        }
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let scoreData = scoreData else { return 0 }
        return scoreData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let scoreData = scoreData?[section] as? Array<Person> else { return 0 }
        print ("sections = \(scoreData.count)")
        return scoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! PersonCell
        if let scoreData = scoreData?[indexPath.section] as? Array<Person> {
            cell.setPersonInfo(scoreData[indexPath.row].name ?? "", score: scoreData[indexPath.row].score ?? 0)
            return cell
        } else {
            cell.setPersonInfo("No Data", score: 0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "sectionHeader")
        let cell = header as! SectionHeaderView
        
        switch (section) {
        case 0:
            cell.sectionTitle.text = "males"
            cell.backgroundColor = .cyan
        case 1:
            cell.sectionTitle.text = "females"
            cell.backgroundColor = .magenta
        default:
            cell.sectionTitle.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let scoreData = scoreData?[indexPath.section] as? Array<Person> {
            selectedPerson = scoreData[indexPath.row]
            performSegue(withIdentifier: "detailSeque", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

