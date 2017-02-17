//
//  PatientTableViewCell.swift
//  PatientList
//
//  Created by Yatin on 14/12/16.
//  Copyright © 2016 MAPD-SPY. All rights reserved.
//

import UIKit

class PatientTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
      @IBOutlet weak var agelabel: UILabel!
      @IBOutlet weak var addresslabel: UILabel!
      @IBOutlet weak var departmentlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
