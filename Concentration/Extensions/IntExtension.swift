//
//  IntExtension.swift
//  Concentration
//
//  Created by Lyudmila Platonova on 6/21/20.
//  Copyright © 2020 Lyudmila Platonova. All rights reserved.
//

import Foundation

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
