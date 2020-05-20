//
//  SocialCell.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 19/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

protocol SocialCellDelegate: AnyObject {
    func didTapFacebook()
    func didTapTwitter()
    func didTapInstagram()
}

class SocialCell: UITableViewCell, CellIdentifier {
    weak var delegate: SocialCellDelegate?

    // MARK: UI

    private lazy var followUsLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("follow_us", comment: "")
        label.textColor = Color.smaltBlue
        label.font = .font(.headline6)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var followUsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.body1)
        label.textColor = Color.midGray
        label.text = NSLocalizedString("follow_us_description", comment: "")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var instagramButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Social.instagram, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configureTargets()
        button.heightAnchor.constraint(equalToConstant: 38).isActive = true

        return button
    }()

    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Social.facebook, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configureTargets()
        button.heightAnchor.constraint(equalToConstant: 38).isActive = true

        return button
    }()

    private lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Social.twitter, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configureTargets()
        button.heightAnchor.constraint(equalToConstant: 38).isActive = true

        return button
    }()

    // MARK: Object lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup methods

    public func setup(with social: [SocialNetwork]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        social.forEach { socialNetwork in
            switch socialNetwork {
            case .facebook:
                stackView.addArrangedSubview(facebookButton)
            case .instagram:
                stackView.addArrangedSubview(instagramButton)
            case .twitter:
                stackView.addArrangedSubview(twitterButton)
            }
        }
    }

    private func setupView() {
        selectionStyle = .none
        [stackView, followUsLabel, followUsDescriptionLabel].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            followUsLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            followUsLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            followUsLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            followUsDescriptionLabel.topAnchor.constraint(equalTo: followUsLabel.bottomAnchor, constant: 10),
            followUsDescriptionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            followUsDescriptionLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            stackView.topAnchor.constraint(equalTo: followUsDescriptionLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }

    // MARK: Helpers

    @objc private func didTapFacebook() {
        delegate?.didTapFacebook()
    }

    @objc private func didTapTwitter() {
        delegate?.didTapTwitter()
    }

    @objc private func didTapInstagram() {
        delegate?.didTapInstagram()
    }
}
