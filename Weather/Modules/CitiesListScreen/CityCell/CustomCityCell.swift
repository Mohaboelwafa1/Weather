//
//  CustomCityCell.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit
import Kingfisher

class CustomCityCell : UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setModel(model : CityCellModel)   {
        self.timeLabel.text = String(describing: model.currentTime)
        self.cityNameLabel.text = String(describing: model.cityName)
        self.temperatureLabel.text = String(describing: model.temp)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.downloadImageForCity(url: model.backGroundImage, imageview: imageView)
        imageView.alpha = 0.9
        self.backgroundView = UIView()
        self.backgroundView!.addSubview(imageView)
    }

    func downloadImageForCity(url : String, imageview : UIImageView) {
        let url = URL(string: url)
        let processor = DownsamplingImageProcessor(size: imageview.bounds.size)
        imageview.kf.indicatorType = .activity
        imageview.kf.setImage(
            with: url,
            placeholder: R.image.cityPlaceHolder(),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
