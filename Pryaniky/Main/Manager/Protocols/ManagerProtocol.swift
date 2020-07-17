//
//  ManagerProtocol.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 16.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

protocol MainManagerProtocol: AnyObject {
	var numberOfItems: Int { get }
	
	func updateData(completion: @escaping VoidDataCallback)
	subscript(_ index: Int) -> DataModelType { get }
}
