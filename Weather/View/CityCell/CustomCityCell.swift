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
    }

    func setModel(model : CityCellModel)   {
        self.timeLabel.text = String(describing: model.currentTime)
        self.cityNameLabel.text = String(describing: model.cityName)
        self.tempretureLabel.text = String(describing: model.tempreture)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        //imageView.kf.setImage(with: URL(string: model.backGroundImage), placeholder: UIImage(named: "LaunchScreenBG"), options: .none, progressBlock: nil, completionHandler: nil)
        //imageView.kf.setImage(with: URL(string: model.backGroundImage))
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
            placeholder: UIImage(named: "cityPlaceHolder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
