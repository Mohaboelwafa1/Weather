//
//  AsyncImageView.swift
//  Weather
//
//  Created by Mohammed hassan on 8/11/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit

class AsyncImageView: UIView {

    private var _image: UIImage?

    var image: UIImage? {
        get {
            return _image
        }

        set {
            _image = newValue

            layer.contents = nil

            guard let image = newValue else { return }

            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.sync { }

                let decodedImage = UIImage.decodedImage(image)

                DispatchQueue.main.async {
                    self.layer.contents = decodedImage?.cgImage
                }
            }
        }
    }

}
