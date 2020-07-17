//
//  SelectorManager.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

final class SelectorManager: SelectorManagerProtocol {
	
	var numberOfItems: Int {
		return variants.count
	}
	
	var selectedIndex: Int?

	private var variants: [Variant] = []
	
	func setup(selectedIndex: Int, variants: [Variant]) {
		guard variants.indices.contains(selectedIndex) else { return }
		self.variants = variants.sorted { $0.id < $1.id }
		self.selectedIndex = selectedIndex
	}
	
	subscript(_ index: Int) -> Variant? {
		guard variants.indices.contains(index) else { return nil }
		return variants[index]
	}
}
