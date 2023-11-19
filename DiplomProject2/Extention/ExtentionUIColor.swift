//
//  ExtentionUIColor.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

struct Palette {
    static let labelColor: UIColor = {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.red
            } else {
                return UIColor.green
            }
        }
    }()
    
    static let buttonColor: UIColor = {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.red
            } else {
                return UIColor.green
            }
        }
    }()
    
    static let backgroundColor: UIColor = {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.red
            } else {
                return UIColor.green
            }
        }
    }()
}

extension UIColor {
        
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return lightMode
            } else {
                return darkMode
            }
        }
    }
    
    static func createCGolor(lightMode: UIColor, darkMode: UIColor) -> CGColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return lightMode
            } else {
                return darkMode
            }
        } .cgColor
    }
}
