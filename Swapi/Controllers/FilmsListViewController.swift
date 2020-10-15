//
//  FilmsListViewController.swift
//  Swapi
//
//  Created by Katrina on 2020-10-14.
//

import Foundation
import UIKit

class FilmsListViewController: UIViewController {
	
	// MARK: - Properties & Vars
	private var viewModel: SwapiViewModel?
	
	let loadingView: LoadingView = {
		let view = LoadingView()
		return view
	}()
	
	let tableView: UITableView = {
		let table = UITableView()
		return table
	}()
	
	// MARK: - Funcs
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel = SwapiViewModel(delegate: self)
		viewModel?.fetchFilms()
		
		setupViews()
		setupTableView()
	}
	
	// MARK: - Setup
	private func setupViews() {
		navigationItem.title = "Star Wars Films"
		view.addSubview(tableView)
		view.addSubview(loadingView)
		setupLayouts()
	}
	
	private func setupLayouts() {
		tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
		loadingView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.reuseIdentifier)
	}
}

// MARK: - TableView
extension FilmsListViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let filmVC = FilmDetailViewController()
		filmVC.film = viewModel?.findFilm(at: indexPath.row)
		navigationController?.pushViewController(filmVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.totalCount ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.reuseIdentifier, for: indexPath) as? FilmCell else { fatalError("Error dequeueing FilmCell") }
		if indexPath.row <= viewModel?.currentCount ?? 0 {
			cell.film = viewModel?.findFilm(at: indexPath.row)
		}
		return cell
	}
}

// MARK: - VMDelegate
extension FilmsListViewController: StarWarsViewModelDelegate {
	func fetchDidSucceed() {
		tableView.reloadData()
		
		if viewModel?.totalCount == viewModel?.currentCount {
			loadingView.removeFromSuperview()
		}
	}
	
	func fetchDidFail(with title: String, description: String) {
		Alert.showAlert(title: title, message: description, on: self)
	}
}
