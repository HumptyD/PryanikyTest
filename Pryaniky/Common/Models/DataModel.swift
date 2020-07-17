//
//  DataModel.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import Foundation

struct DataModel: Codable {
	let text: String?
	let url: String?
	var selectedId: Int?
	let variants: [Variant]?
}
