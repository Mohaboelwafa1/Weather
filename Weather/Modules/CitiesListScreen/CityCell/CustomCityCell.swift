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
        self.setBackgroundImage(imageURL: model.backGroundImage)
    }

    private func setBackgroundImage(imageURL : String) {
        let outerView = UIView(frame: CGRect(x: 10, y: 10, width: self.frame.width - 20, height: self.frame.height - 20))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath

        let imageView = UIImageView(frame: outerView.bounds)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        self.downloadImage(url: imageURL, imageview: imageView)
        imageView.alpha = 0.9

        outerView.addSubview(imageView)
        self.backgroundView = UIView()
        self.backgroundView!.addSubview(outerView)
    }

    private func downloadImage(url : String, imageview : UIImageView) {
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
