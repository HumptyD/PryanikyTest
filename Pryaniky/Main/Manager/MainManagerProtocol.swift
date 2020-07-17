//
//  ManagerProtocol.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import Foundation

protocol MainManagerProtocol: AnyObject {
	var numberOfItems: Int { get }
	
	func updateData(completion: @escaping VoidDataCallback)
	func upadateSelectedItemAtIndexPath(_ indexPath: IndexPath, withNewSelectedID id: Int)
	subscript(_ index: Int) -> DataModelType { get }
}
