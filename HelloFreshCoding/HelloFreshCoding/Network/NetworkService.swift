//
//  NetworkService.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)) {
        self.session = session
    }
    
    func fetch<T>(_ url: String, completion: @escaping ResultHandler<T>) where T : Decodable {
        let url = URL(string: url)!
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode.isSuccessHTTPCode,
                  let data = data else {
                      if let error = error {
                          completion(.failure(NetworkError(error: error)))
                          
                      } else {
                          completion(.failure(NetworkError(response: response)))
                      }
                      return
                  }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError(error: error)))
            }
        })
        
        task.resume()
    }
}
//MARK:- Error code
extension Int {
    public var isSuccessHTTPCode: Bool {
        return 200 <= self && self < 300
    }
}
