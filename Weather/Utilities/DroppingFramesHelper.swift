//
//  DroppingFramesHelper.swift
//  Weather
//
//  Created by Mohammed hassan on 8/11/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import Foundation
import UIKit

public class DroppingFramesHelper: NSObject {

    private var firstTime: TimeInterval = 0.0
    private var lastTime: TimeInterval = 0.0

    func activate() {
        let link = CADisplayLink(target: self, selector: #selector(update(link:)))
        link.add(to: .main, forMode: .common)
    }

    @objc private func update(link: CADisplayLink) {
        if lastTime == 0 {
            firstTime = link.timestamp
            lastTime = link.timestamp
        }

        let currentTime = link.timestamp

        let elapsedTime = floor((currentTime - lastTime) * 10_000)/10
        let totalElapsedTime = currentTime - firstTime
        if elapsedTime > 16.7 {
            print("[DFH] Frame was dropped with elpased time of \(elapsedTime)ms at \(totalElapsedTime)")
        }
        lastTime = link.timestamp
    }

}
