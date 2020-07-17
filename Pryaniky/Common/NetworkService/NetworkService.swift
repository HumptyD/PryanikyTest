//
//  DataService.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
	
	func updateData(url: String, completion: @escaping LoadedDataCallback) {
		guard let url = URL(string: url) else { return }
		let configuration = URLSessionConfiguration.ephemeral
		let session = URLSession(configuration: configuration)
		session.dataTask(with: url) { data, _, error in
			if let error = error {
				completion(.failure(error))

			}
			guard let data = data else { return }
			let jsonDecoder = JSONDecoder()
			do {
				let internalData = try jsonDecoder.decode(InternalData.self, from: data)
				completion(.success(internalData))
			} catch {
				completion(.failure(error))
			}
		}.resume()
	}
}
