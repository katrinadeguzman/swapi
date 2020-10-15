//
//  LoadingView.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation
import UIKit

class LoadingView: UIView {
	
	// MARK: - Views
	let blurView: UIVisualEffectView = {
		let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
		let blurView = UIVisualEffectView(effect: blurEffect)
		return blurView
	}()
	
	let activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style: .medium)
		indicator.startAnimating()
		return indicator
	}()
	
	let label: UILabel = {
		let label = UILabel()
		label.textColor = UIColor.systemGray
		label.text = "Loading films..."
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		return label
	}()
	
	let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = NSLayoutConstraint.Axis.vertical
		stackView.alignment = UIStackView.Alignment.center
		stackView.spacing = 32
		return stackView
	}()
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	private func setupView() {
		backgroundColor = .clear
		
		insertSubview(blurView, at: 0)
		addSubview(stackView)
		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(activityIndicator)
		
		setupLayouts()
	}
	
	private func setupLayouts() {
		blurView.fillSuperview()
		stackView.center(in: self)
	}
}
