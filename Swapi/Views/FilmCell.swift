//
//  FilmCell.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation
import UIKit
class FilmCell: UITableViewCell {
	
	// MARK: - Properties & Vars
	static var reuseIdentifier: String {
		String(describing: self)
	}
	
	static var nib: UINib {
		return UINib(nibName: String(describing: self), bundle: nil)
	}
	
	var film: Film! {
		didSet {
			textLabel?.text = film.title
		}
	}
	
	// MARK: - Funcs
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Show last selected cell
		let backgroundView = UIView()
		backgroundView.backgroundColor = .lightGray
		selectedBackgroundView = backgroundView
		textLabel?.textColor = isSelected ? .black : UIColor.label
	}
}
