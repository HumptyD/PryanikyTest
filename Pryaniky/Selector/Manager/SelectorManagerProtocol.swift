//
//  SelectorManagerProtocol.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

protocol SelectorManagerProtocol: AnyObject {
	var numberOfItems: Int { get }
	var selectedIndex: Int? { get }
	
	func setup(selectedIndex: Int, variants: [Variant])
	subscript(_ index: Int) -> Variant? { get }
}
