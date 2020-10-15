//
//  DetailHeader.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation
import UIKit

class DetailHeader: UITableViewHeaderFooterView {
	
	// MARK: - Properties & Vars
	var title = UILabel()
	
	static var reuseIdentifier: String {
		String(describing: self)
	}
	
	var section: Int = 0 {
		didSet {
			title.text = Attributes(rawValue: section)?.title
		}
	}
	
	// MARK: - Init
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Funcs
	private func setupView() {
		title.font = UIFont.preferredFont(forTextStyle: .headline)
		contentView.addSubview(title)
		setupLayouts()
	}
	
	private func setupLayouts() {
		title.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 8, right: 8))
	}
}
