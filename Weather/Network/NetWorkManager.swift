//
//  NetWorkManager.swift
//  Quiz
//
//  Created by Fábio Pontes on 16/09/2022.
//

import Foundation

struct NetWorkManager{
    
    /// singleton
    static let shared = NetWorkManager()
    private init(){}
    
    func currentWeather(cityName: String = "Leeds",
                        completion: @escaping(Result<CurrentWeather, Error>) -> Void) {
        request(urlString: "https://weatherbit-v1-mashape.p.rapidapi.com/current?city=\(cityName)&lang=en",
                completion: completion)
        
        }
    
    func forecat(cityName: String = "Leeds",
                    completion: @escaping(Result<ForecastWeather, Error>) -> Void) {
        request(urlString: "https://weatherbit-v1-mashape.p.rapidapi.com/forecast/daily?lat=53.8008&lon=1.5491&lang=en",
                completion: completion)
        
    }
   
  
    
    private func request<T: Decodable>( urlString: String ,completion: @escaping(Result<T, Error>) -> Void) {
        print(urlString)
        
        let headers = [
            "X-RapidAPI-Key": "0a19cd7199mshcdf1fd33a761297p129ed5jsnd8754a745940",
            "X-RapidAPI-Host": "weatherbit-v1-mashape.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        print(request)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
            } else {
                let httpResponse = response as? HTTPURLResponse
//                print("\(String(data: data!, encoding: .utf8)!)\n\n")
                let decoder = JSONDecoder()
                do {
                    if let dat = data {
                        let decodeData = try decoder.decode(T.self, from: dat)
                        completion(.success(decodeData))
                    } else {
                        completion(.failure(AppError.invalidData))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        })
        dataTask.resume()
    }
    
    
   
    
}

