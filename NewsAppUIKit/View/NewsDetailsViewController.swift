//
//  NewsDetailsViewController.swift
//  NewsAppUIKit
//
//  Created by MacBook Pro on 16/11/21.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    var article: Article!
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = article.title
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var newsSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = article.content ?? "No content"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var newsAuthorLabel: UILabel = {
        let label = UILabel()
        label.text = article.author ?? "No author"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var newsSourceNameLabel: UILabel = {
        let label = UILabel()
        label.text = article.source.name ?? "Unknown"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        newsImageView.addGestureRecognizer(tapGestureRecognizer)
        setupScrollView()
        layoutSubviews()
        imageLoad(article: article)
    }
    
    @objc private func didTapImageView(_ sender: UITapGestureRecognizer) {
        let newsImageVC = NewsImageViewController()
        newsImageVC.imageUrl = article.urlToImage
        navigationController?.pushViewController(newsImageVC, animated: true)
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func layoutSubviews() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        newsSourceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsAuthorLabel)
        contentView.addSubview(newsSourceNameLabel)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSubtitleLabel)
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MagicNumber.x),
            newsImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -MagicNumber.x2),
            newsImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: MagicNumber.x2),
            newsImageView.heightAnchor.constraint(equalToConstant: 250),
            newsAuthorLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: MagicNumber.x2),
            newsAuthorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -MagicNumber.x2),
            newsSourceNameLabel.topAnchor.constraint(equalTo: newsAuthorLabel.bottomAnchor, constant: MagicNumber.x),
            newsSourceNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -MagicNumber.x2),
            newsTitleLabel.topAnchor.constraint(equalTo: newsSourceNameLabel.bottomAnchor, constant: MagicNumber.x3),
            newsTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: MagicNumber.x2),
            newsTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -MagicNumber.x2),
            newsSubtitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: MagicNumber.x2),
            newsSubtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: MagicNumber.x2),
            newsSubtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -MagicNumber.x2),
            newsSubtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func imageLoad(article: Article) {
        guard let url = URL(string: article.urlToImage ?? EmptyImage.imgUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.newsImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
