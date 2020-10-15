//
//  String+Custom.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation
import UIKit

extension String {
	func customizeString(color: UIColor, fontSize: CGFloat, weight: UIFont.Weight) -> NSMutableAttributedString {
		return NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor: color,
																																				NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: weight)])
	}
}
