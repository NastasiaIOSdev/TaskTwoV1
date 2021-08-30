//
//  UIColor+Extension.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 30.08.2021.
//

import Foundation
import UIKit

extension UIColor {

   static func setColor(lightColor: UIColor, darkColor: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .light ? lightColor : darkColor
            }
        } else {
            return lightColor
        }
    }
}
