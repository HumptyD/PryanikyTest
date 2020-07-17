//
//  CommonConstants.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

typealias LoadedDataCallback = (Result<InternalData, Error>) -> Void
typealias VoidDataCallback = (Result<Void, Error>) -> Void
typealias VoidCallBack = () -> Void

enum CommonConstants {
	static let urlName = "https://pryaniky.com/static/json/sample.json"
}
