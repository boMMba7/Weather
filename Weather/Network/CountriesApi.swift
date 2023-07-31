//
//  CountriesApi.swift
//  Weather - FPontes
//
//  Created by Fábio Pontes on 30/07/2023.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case serverError
    case invalidResponse
    // Add more error cases as needed
}

struct CountriesAPI{
    
    /// singleton
    static let shared = CountriesAPI()
    private init(){}
    
    func searchCountryes(keyword:String,
                 completion: @escaping(Result<[JsonCity], Error>) -> Void) {
        request(urlString: "https://country-info-api-env.eba-ewjpnpa3.us-east-1.elasticbeanstalk.com/city/search/\(keyword)",
                completion: completion)
    }
    
    private func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
//            print("\(String(data: data!, encoding: .utf8)!)\n\n")
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(T.self, from: data)
                completion(.success(decodeData))
                
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
