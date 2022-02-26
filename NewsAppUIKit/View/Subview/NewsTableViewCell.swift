//
//  NewsTableViewCell.swift
//  NewsAppUIKit
//
//  Created by MacBook Pro on 16/11/21.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, imageURL: URL?) {
        self.title = title
        self.imageURL = imageURL
    }
}

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsImageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupConstraints() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MagicNumber.x),
            newsImageView.trailingAnchor.constraint(equalTo: newsTitleLabel.leadingAnchor, constant: -MagicNumber.x),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MagicNumber.x),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -MagicNumber.x),
            newsImageView.widthAnchor.constraint(equalToConstant: 200),
            newsImageView.heightAnchor.constraint(equalToConstant: 120),
            newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: MagicNumber.x),
            newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MagicNumber.x),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MagicNumber.x),
            newsTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -MagicNumber.x)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
