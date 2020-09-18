//
//  CellBackgroundImageSetter.swift
//  Weather
//
//  Created by Mohammed hassan on 9/18/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit

class CellBackgroundImageSetter {

    static func setBackgroundImage(imageURL : String, cell: UIView) {
        if cell.isKind(of: UITableViewCell.self) || cell.isKind(of: UICollectionViewCell.self) {
            let outerView = UIView(frame: CGRect(x: 10, y: 10, width: cell.frame.width - 20, height: cell.frame.height - 20))
            outerView.clipsToBounds = false
            outerView.layer.shadowColor = UIColor.black.cgColor
            outerView.layer.shadowOpacity = 1
            outerView.layer.shadowOffset = CGSize.zero
            outerView.layer.shadowRadius = 10
            outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath

            let imageView = UIImageView(frame: outerView.bounds)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            ImageDownloader.downloadImage(url: imageURL, imageview: imageView)
            imageView.alpha = 0.9

            outerView.addSubview(imageView)
            if cell.isKind(of: UITableViewCell.self) {
                (cell as! UITableViewCell).backgroundView = UIView()
                (cell as! UITableViewCell).backgroundView!.addSubview(outerView)
            } else {
                (cell as! UICollectionViewCell).backgroundView = UIView()
                (cell as! UICollectionViewCell).backgroundView!.addSubview(outerView)
            }

        }

    }

}
