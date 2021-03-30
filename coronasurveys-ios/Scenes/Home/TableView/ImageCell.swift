//
//  ImageCell.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 20/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell, CellIdentifier {
    // MARK: UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.smaltBlue
        label.font = .font(.headline6)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    // MARK: Object lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup methods

    public func setup(title: String, url: String?) {
        titleLabel.text = title
        titleLabel.numberOfLines = 0

        if let urlRaw = url, let url = URL(string: urlRaw) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) // make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.mainImage.image = UIImage(data: data!)
                }
            }
        }
    }

    private func setupView() {
        selectionStyle = .none
        [titleLabel, mainImage].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            mainImage.heightAnchor.constraint(equalTo: mainImage.widthAnchor, multiplier: 1.3),
            mainImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            mainImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            mainImage.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
