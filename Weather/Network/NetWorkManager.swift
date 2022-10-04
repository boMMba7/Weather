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
    
    /// request the current weather
    /// - Parameters:
    ///   - cityName: city where the wheather information belong
    ///   - completion: way to return the result of request, error or data
    func currentWeather(lat: String,
                        long: String,
                        completion: @escaping(Result<CurrentWeather, Error>) -> Void) {
        request(urlString: "https://weatherbit-v1-mashape.p.rapidapi.com/current?lat=\(lat)&lon=\(long)&lang=en",
                completion: completion)
        
        }
    
    /// make a request of the forecast weather
    /// - Parameters:
    ///   - cityName: city of the city to forecast the weather
    ///   - completion: way to return the result of request, error or data
    func forecat(lat: String,
                 long: String,
                 completion: @escaping(Result<ForecastWeather, Error>) -> Void) {
        request(urlString: "https://weatherbit-v1-mashape.p.rapidapi.com/forecast/daily?lat=\(lat)&lon=\(long)&lang=en",
                completion: completion)
        
    }
   
  
    
    /// creat a request , do the request and decode the data from the request
    /// - Parameters:
    ///   - urlString: string representing the url request
    ///   - completion: way to return the result of the request , data or error
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
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
            } else {
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

