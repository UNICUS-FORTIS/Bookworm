//
//  Network.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/04.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func requestData(bookname: String,
                     page: Int,
                     completion: @escaping (Result<KakaoBook, NetworkError>) -> Void) {
        
        guard let url = URL.requestKakaoBook(bookname: bookname, page: page) else { return }
        var request = URLRequest(url: url)
        
        request.addValue(Headers.HeaderValue, forHTTPHeaderField: Headers.HeaderName)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
                        
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            do {
                
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(KakaoBook.self, from: safeData)
                completion(.success(searchResult))

            } catch {
                
                completion(.failure(.parseError))
                
            }
        }.resume()
    }
}

