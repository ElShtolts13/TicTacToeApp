//
//  UIFont + Ext.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 30.09.2024.
//

import UIKit


extension UIFont {
    enum SFProDisplay {
        
        enum bold {
                    static func size(of size: CGFloat) -> UIFont? {
                        guard let font = UIFont(name: Constants.SFProDisplay.bold, size: size) else {
                            print("Font not found: \(Constants.SFProDisplay.bold)")
                            return nil
                        }
                        return font
                    }
                }

        enum semibold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.SFProDisplay.semibold,
                              size: size)!
            }
            
        }
        enum medium {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.SFProDisplay.medium,
                              size: size)!
            }
            
        }
        enum regular {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.SFProDisplay.regular,
                              size: size)!
            }
            
        }
    }
}
    private extension UIFont {
        enum Constants {
            enum SFProDisplay {
                static let bold = "SFProDisplay-Bold"
                static let semibold = "SFProDisplay-Semibold"
                static let medium = "SFProDisplay-Medium"
                static let regular = "SFProDisplay-Regular"
            }
        }
}

