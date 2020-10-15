//
//  RootClass.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation

struct RootClass: Decodable {
		let count: Int
		let next: URL?
		let previous: URL?
		let results: [Film]
}
