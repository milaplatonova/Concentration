//
//  UIButtonExtension.swift
//  Concentration
//
//  Created by Lyudmila Platonova on 30.09.21.
//  Copyright © 2021 Lyudmila Platonova. All rights reserved.
//

import UIKit

extension UIButton {
    
    func buttonCustomization() {
        let spacing: CGFloat = 8.0
        self.contentEdgeInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        self.layer.cornerRadius = 10
    }
    
}
