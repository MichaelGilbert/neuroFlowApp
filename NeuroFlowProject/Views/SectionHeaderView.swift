//
//  SectionHeaderView.swift
//  NeuroFlowProject
//
//  Created by Michael Gilbert on 2/7/20.
//  Copyright © 2020 Michael Gilbert. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewCell {

    @IBOutlet weak var sectionTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
