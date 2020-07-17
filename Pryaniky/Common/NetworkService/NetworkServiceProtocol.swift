//
//  DataServiceProtocol.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

protocol NetworkServiceProtocol: AnyObject {
	func updateData(url: String, completion: @escaping LoadedDataCallback)
}
