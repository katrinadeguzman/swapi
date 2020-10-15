//
//  Film.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation

struct Film: Codable {
	let title: String
	let episodeId: Int
	let openingCrawl: String
	let director: String
	let producer: String
	let releaseDate: String
	let characters: [URL]
}
