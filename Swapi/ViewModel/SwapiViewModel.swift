//
//  SwapiViewModel.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation
import UIKit

protocol StarWarsViewModelDelegate: class {
	func fetchDidSucceed()
	func fetchDidFail(with title: String, description: String)
}

final class SwapiViewModel {
	
	// MARK: - Properties & Vars
	private weak var delegate: StarWarsViewModelDelegate?
	
	init(delegate: StarWarsViewModelDelegate) {
		self.delegate = delegate
	}
	
	var apiClient = APIClient()
	
	private var currentPage = 1
	private var total = 0
	var currentCount: Int { return films.count }
	var totalCount: Int { return total }
	
	private var characters = [Character]()
	private var films = [Film]() {
		didSet {
			// get results count and keep fetching from server until you hit resultsCount
			if currentCount < totalCount {
				fetchFilms()
			}
		}
	}
	
	// MARK: - Funcs
	func findFilm(at index: Int) -> Film {
		return films[index]
	}
	
	func findCharacters() -> [Character] {
		return characters
	}
	
	// MARK: - Fetch Data
	func fetchFilms() {
		apiClient.fetch(with: nil, page: currentPage, dataType: RootClass.self) { result in
			switch result {
				case .failure(let error):
					DispatchQueue.main.async {
						self.delegate?.fetchDidFail(with: error.reason, description: error.localizedDescription)
					}
				case .success(let response):
					// keep track of results count, current page and, fetched films
					DispatchQueue.main.async {
						self.total = response.count
						self.currentPage += 1
						self.films.append(contentsOf: response.results)
						self.delegate?.fetchDidSucceed()
					}
			}
		}
	}
	
	func fetchCharacter(with url: URL) {
		apiClient.fetch(with: url, page: nil, dataType: Character.self) { result in
			switch result {
				case .failure(let error):
					DispatchQueue.main.async {
						self.delegate?.fetchDidFail(with: error.reason, description: error.localizedDescription)
					}
				case .success(let character):
					DispatchQueue.main.async {
						self.characters.append(character)
						self.delegate?.fetchDidSucceed()
					}
			}
		}
	}
}
