//
//  Attributes.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation

enum Attributes: Int, CaseIterable {
	
		case openingCrawl, director, producer, releaseDate, characters
	
		var title: String {
				switch self {
					case .openingCrawl: return "Opening Crawl"
					case .director: return "Director"
					case .producer: return "Producer"
					case .releaseDate: return "Release Date"
					case .characters: return "Characters"
				}
		}
		
		static func getCount() -> Int {
				return self.allCases.count
		}

		static func getSection(_ section: Int) -> Attributes {
				return self.allCases[section]
		}
}
