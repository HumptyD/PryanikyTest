//
//  PryanikyManager.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import Foundation

final class MainManager: MainManagerProtocol {

	var numberOfItems: Int {
		return dataModels.count
	}
	
	private let networkService: NetworkServiceProtocol
	private var dataModels: [DataModelType] = []
	
	init() {
		networkService = NetworkService()
	}
	
	func updateData(completion: @escaping VoidDataCallback) {
		networkService.updateData(url: CommonConstants.urlName) { [weak self] result in
			guard let self = self else {
				// По-хорошему можно добавить сюда кастомную ошибку и вызвать completion(.failure(error))
				return
			}
			switch result {
			case .success(let internalData):
				internalData.view.forEach { dataTypeName in
					if let element = internalData.data.first(where: { $0.name == dataTypeName }) {
						self.dataModels.append(element)
					}
				}
				completion(.success(()))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func upadateSelectedItemAtIndexPath(_ indexPath: IndexPath, withNewSelectedID id: Int) {
		dataModels[indexPath.row].data.selectedId = id
	}
	
	subscript(_ index: Int) -> DataModelType {
		return dataModels[index]
	}
}
