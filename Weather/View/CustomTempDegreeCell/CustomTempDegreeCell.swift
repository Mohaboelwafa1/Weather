//
//  CustomTempDegreeCell.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
// CustomTempDegreeCell

import Foundation
import UIKit
import Kingfisher

class CustomTempDegreeCell : UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setModel(model : CustomTempDegreeCellModel) {
        self.dateLabel.text = String(describing: model.todayDate)
        self.timeLabel.text = String(describing: model.currentTime)
        self.degreeLabel.text = String(describing: model.tempreture)
        self.timeLabel.text = String(describing: model.currentTime)
        self.iconImage.image = UIImage(named: "\(model.iconImage)")
    }
}
