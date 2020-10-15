//
//  FilmDetailViewController.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation
import UIKit

class FilmDetailViewController: UIViewController {
	
	// MARK: - Properties & Vars
	private var viewModel: SwapiViewModel?
	var characters = [Character]()
	var film: Film! {
		didSet {
			viewModel = SwapiViewModel(delegate: self)
			film.characters.forEach { characterUrl in
				viewModel?.fetchCharacter(with: characterUrl)
			}
			setupViews()
			setupTitleView()
			setupTableView()
		}
	}
	
	var characterString: String = ""
	
	let tableView: UITableView = {
		let table = UITableView()
		return table
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()
	
	// MARK: - Funcs
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		DispatchQueue.main.async {
			self.tableView.tableHeaderView?.layoutIfNeeded()
			self.tableView.tableHeaderView = self.tableView.tableHeaderView
		}
	}
	
	// MARK: - Setup
	private func setupViews() {
		view.addSubview(tableView)
		tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		tableView.register(DetailCell.nib, forCellReuseIdentifier: DetailCell.reuseIdentifier)
		tableView.register(DetailHeader.self, forHeaderFooterViewReuseIdentifier: DetailHeader.reuseIdentifier)
	}
	
	private func setupTitleView() {
		let navTitle = film.title.customizeString(color: UIColor.label, fontSize: 20.0, weight: .bold)
		let navSubtitle = "\nEpisode: \(film.episodeId)".customizeString(color: .secondaryLabel, fontSize: 16.0, weight: .light)
		navTitle.append(navSubtitle)
		titleLabel.attributedText = navTitle
		navigationItem.titleView = titleLabel
	}
}

// MARK: - StarWarsViewModelDelegate
extension FilmDetailViewController: StarWarsViewModelDelegate {
	func fetchDidSucceed() {
		let characters = viewModel?.findCharacters()
		guard film.characters.count == characters?.count else { return }
		
		// list characters in selected film
		characterString = characters?.map {
			"\($0.name) "
		}.joined(separator: "\n") ?? ""
		
		tableView.reloadData()
	}
	
	func fetchDidFail(with title: String, description: String) {
		Alert.showAlert(title: title, message: description, on: self)
	}
}

// MARK: - TableView
extension FilmDetailViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return Attributes.getCount()
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailHeader.reuseIdentifier) as? DetailHeader else { fatalError("Error dequeueing DetailHeader") }
		header.section = section
		return header
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier, for: indexPath) as? DetailCell else { fatalError("Error dequeueing DetailCell")
		}
		
		switch Attributes.getSection(indexPath.section) {
			case .openingCrawl: cell.configureCell(with: film.openingCrawl)
			case .director: cell.configureCell(with: film.director)
			case .producer: cell.configureCell(with: film.producer)
			case .releaseDate: cell.configureCell(with: film.releaseDate)
			case .characters:
				cell.configureCell(with: characterString)
				cell.loadingIndicator.isHidden = false
				cell.loadingIndicator.startAnimating()
				
				if characterString != "" {
					cell.loadingIndicator.stopAnimating()
				}
		}
		
		return cell
	}
}
