//
//  SelectorViewController.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import UIKit

protocol SelectorViewControllerDelegate: AnyObject  {
	func selectorViewControllerDidSelectRowAtIndex(_ index: Int)
}

final class SelectorViewController: UIViewController {
	
	private enum Constants {
		static let numberOfComponents = 1
	}
	
	weak var delegate: SelectorViewControllerDelegate?

	lazy private var pickerView = UIPickerView()
	private let manager: SelectorManagerProtocol
	
	init() {
		manager = SelectorManager()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .lightGray
		setupPicker()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		let selectedRow = pickerView.selectedRow(inComponent: .zero)
		delegate?.selectorViewControllerDidSelectRowAtIndex(selectedRow)
	}
	
	func setupItem(selectedId: Int, variants: [Variant]) {
		manager.setup(selectedIndex: selectedId, variants: variants)
	}

	private func setupPicker() {
		pickerView.delegate = self
		pickerView.dataSource = self
		pickerView.backgroundColor = .lightGray
		
		view.addSubview(pickerView)
		let constraints = [
			pickerView.topAnchor.constraint(equalTo: view.topAnchor),
			pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		]
		NSLayoutConstraint.activate(constraints)
		
		if let index = manager.selectedIndex {
			pickDefaultRow(at: index)
		}
	}
	
	private func pickDefaultRow(at index: Int) {
		guard manager.numberOfItems > index else { return }
		pickerView.selectRow(index, inComponent: .zero, animated: false)
	}
}

extension SelectorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return Constants.numberOfComponents
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return manager.numberOfItems
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return manager[row]?.text
	}
}
