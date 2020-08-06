//
//  CustomCityCell.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CustomCityCell : UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempretureLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // TODO: -MH- Add background
    }

    func setModel(model : CityCellModel)   {
        self.timeLabel.text = String(describing: model.currentTime)
        self.cityNameLabel.text = String(describing: model.cityName)
        self.tempretureLabel.text = String(describing: model.tempreture)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        imageView.kf.setImage(with: URL(string: model.backGroundImage))
        self.backgroundView = UIView()
        self.backgroundView!.addSubview(imageView)
    }
}
