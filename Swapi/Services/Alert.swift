//
//  Alert.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation
import UIKit

class Alert {
	private init() {
		print("Alert singleton initialized")
	}
	
	static func showAlert(title: String, message: String, on vc: UIViewController) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Okay!", style: .default) { action in
			vc.dismiss(animated: true, completion: nil)
		}
		alert.addAction(okAction)
		vc.present(alert, animated: true)
	}
}
