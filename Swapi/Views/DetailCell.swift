//
//  DetailCell.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation
import UIKit

class DetailCell: UITableViewCell {
	
	// MARK: - Properties, Outlets, & Vars
	static var reuseIdentifier: String {
		String(describing: self)
	}
	
	static var nib: UINib {
		return UINib(nibName: String(describing: self), bundle: nil)
	}
	
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var loadingIndicator: UIActivityIndicatorView! {
		didSet {
			loadingIndicator.hidesWhenStopped = true
			loadingIndicator.isHidden = true
		}
	}
	
	// MARK: - Funcs
	func configureCell(with text: String) {
		label?.text = text
	}
}
