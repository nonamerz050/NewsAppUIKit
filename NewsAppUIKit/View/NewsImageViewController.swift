//
//  NewsImageViewController.swift
//  NewsAppUIKit
//
//  Created by MacBook Pro on 16/11/21.
//

import UIKit

class NewsImageViewController: UIViewController {

    var imageUrl: String!
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageLoad(stringUrl: imageUrl)
        layoutSubviews()

    }
    func imageLoad(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.newsImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    private func layoutSubviews() {
        view.addSubview(newsImageView)
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: MagicNumber.x),
            newsImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -MagicNumber.x2),
            newsImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: MagicNumber.x2),
            newsImageView.heightAnchor.constraint(equalToConstant: 500)
            ])
    }
}
