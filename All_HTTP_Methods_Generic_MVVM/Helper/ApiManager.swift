//
//  ApiManager.swift
//  All_HTTP_Methods_Generic_MVVM
//
//  Created by PHN Tech 2 on 09/06/23.
//

import Foundation

enum FetchingError : Error{
    case invalidUrl
    case invalidData
    case invalidResponse
    case decodingError(Error)
}

enum Event{
    case startLoading
    case stopLoading
    case reloadData
    case error(FetchingError)
}

typealias complitionHandler<T> = (Result<T, FetchingError>) -> ()

final class ApiManager{
    static let shared = ApiManager()
    private init(){}
    
    func apiCall<T : Decodable>(model : T.Type, type : EndpointItems, complitionHandler : @escaping complitionHandler<T>){
        guard let url = type.url else{
            complitionHandler(.failure(.invalidUrl))
            return}
        
        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod.rawValue
        
        if let body = type.parameter{
            request.httpBody = body
            request.allHTTPHeaderFields = type.header
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                complitionHandler(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else{
                complitionHandler(.failure(.invalidResponse))
                return
            }
            
            do{
                let result = try JSONDecoder().decode(model, from: data)
                complitionHandler(.success(result))
            }catch let err{
                complitionHandler(.failure(.decodingError(err)))
            }
        }
        .resume()
        
    }
}
