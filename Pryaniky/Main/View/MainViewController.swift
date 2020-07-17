//
//  ViewController.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
	
	private enum Constants {
		static let mainTitle = "MainTitle"
		static let objectNameTitle = "Object Name"
		static let errorTitle = "Error"
	}
	
	private lazy var tableView = UITableView(frame: view.frame)
	private let manager: MainManagerProtocol
	private var currentSelectionPickerIndexPath: IndexPath?
	
	init() {
		manager = MainManager()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = Constants.mainTitle
		setupTableView()
		reloadData()
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellReuseIdentifier)
		view.addSubview(tableView)
	}
	
	private func reloadData() {
		manager.updateData { [weak self] result in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result {
				case .success():
					self.tableView.reloadData()
				case .failure(let error):
					self.presentAlert(title: Constants.errorTitle, name: error.localizedDescription)
				}
			}
		}
	}
	
	private func configure(_ cell: MainTableViewCell, with item: DataModel) {
		if let url = item.url {
			setupImageFor(cell: cell, urlName: url)
		}
		cell.titleLabel.text = createTextForLabel(with: item)
		cell.selectionStyle = .none
	}
	
	private func createTextForLabel(with item: DataModel) -> String? {
		var resultText: String?
		if let text = item.text {
			resultText = text
		}
		if let selectedId = item.selectedId, let variants = item.variants,
			variants.indices.contains(selectedId) {
			resultText = variants[selectedId].text
		}
		return resultText
	}
	
	private func setupImageFor(cell: MainTableViewCell, urlName: String) {
		guard let url = URL(string: urlName) else { return }
		
		let configuration = URLSessionConfiguration.ephemeral
		let session = URLSession(configuration: configuration)
		session.dataTask(with: url) { [weak cell] data, _, _ in
			guard let data = data, let image = UIImage(data: data) else { return }
			DispatchQueue.main.async {
				cell?.mainImageView.image = image
			}
		}.resume()
	}
	
	private func presentAlert(title: String, name: String, completion: VoidCallBack? = nil) {
		let alert = UIAlertController(title: title, message: name, preferredStyle: .alert)
		
		var handler: ((UIAlertAction) -> Void)?
		if let completion = completion {
			handler = { _ in completion() }
		}
		
		
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
		present(alert, animated: true)
	}
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, SelectorViewControllerDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return manager.numberOfItems
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellReuseIdentifier, for: indexPath) as? MainTableViewCell else {
			return UITableViewCell()
		}
		let item = manager[indexPath.row]
		configure(cell, with: item.data)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = manager[indexPath.row]
		var pickerShowingHandler: VoidCallBack?

		if let selectedID = item.data.selectedId, let variants = item.data.variants {
			pickerShowingHandler = { [weak self] in
				self?.currentSelectionPickerIndexPath = indexPath
				self?.showPickerScene(selectedID: selectedID, variants: variants)
			}
		}

		presentAlert(title: Constants.objectNameTitle, name: item.name, completion: pickerShowingHandler)
	}
	
	func selectorViewControllerDidSelectRowAtIndex(_ index: Int) {
		guard let indexPath = currentSelectionPickerIndexPath else { return }
		manager.upadateSelectedItemAtIndexPath(indexPath, withNewSelectedID: index)
		tableView.reloadData()
	}
	
	private func showPickerScene(selectedID: Int, variants: [Variant]) {
		let selectorVC = SelectorViewController()
		selectorVC.delegate = self
		selectorVC.setupItem(selectedId: selectedID, variants: variants)
		navigationController?.pushViewController(selectorVC, animated: true)
	}
}
