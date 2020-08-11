//
//  UIImageExtension.swift
//  Weather
//
//  Created by Mohammed hassan on 8/11/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit

extension UIImage {

    class func decodedImage(_ image: UIImage) -> UIImage? {
        guard let newImage = image.cgImage else { return nil }

        let colorspace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil,
                                width: newImage.width,
                                height: newImage.height,
                                bitsPerComponent: 8,
                                bytesPerRow: newImage.width * 4,
                                space: colorspace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

        context?.draw(newImage, in: CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height))
        let drawnImage = context?.makeImage()

        if let drawnImage = drawnImage {
            return UIImage(cgImage: drawnImage)
        }

        return nil
    }

}
