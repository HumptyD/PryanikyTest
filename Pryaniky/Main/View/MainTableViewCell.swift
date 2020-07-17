//
//  PryanikyTableViewCell.swift
//  Pryaniky
//
//  Created by Armik Khachatryan on 17.07.2020.
//  Copyright © 2020 Armik Khachatryan. All rights reserved.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
	
	static let cellReuseIdentifier = "PryanikyTableViewCell"
	
	let mainImageView = UIImageView(frame: CGRect(x: .zero, y: .zero, width: 64, height: 64))
	let titleLabel = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupMainImageView()
		setupTitleLabel()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		#if DEBUG
			fatalError("init(coder:) has not been implemented")
		#endif
	}

	private func setupTitleLabel() {
		titleLabel.numberOfLines = 0
		titleLabel.textAlignment = .left
		
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		let constraints = [
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0),
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
			titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 64.0),
			titleLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 5.0)
		]
		NSLayoutConstraint.activate(constraints)
	}

	private func setupMainImageView() {		
		mainImageView.contentMode = .scaleAspectFit
		
		contentView.addSubview(mainImageView)
		mainImageView.translatesAutoresizingMaskIntoConstraints = false
		let constraints = [
			mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
			mainImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			mainImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 64.0),
		]
		NSLayoutConstraint.activate(constraints)
	}
}
