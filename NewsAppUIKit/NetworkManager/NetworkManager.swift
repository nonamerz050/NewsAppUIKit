//
//  NetworkManager.swift
//  NewsAppUIKit
//
//  Created by MacBook Pro on 16/11/21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData(from urlString: String, with completion: @escaping (Result<[Article], Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let news = try JSONDecoder().decode(ArticlesModel.self, from: data)
                completion(.success(news.articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
