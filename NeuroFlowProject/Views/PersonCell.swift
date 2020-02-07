//
//  PersonCell.swift
//  NeuroFlowProject
//
//  Created by Michael Gilbert on 2/7/20.
//  Copyright © 2020 Michael Gilbert. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setPersonInfo(_ name: String, score: Int) {
        personName.text = name;
        personScore.text = "\(score)"
    }
    
}
