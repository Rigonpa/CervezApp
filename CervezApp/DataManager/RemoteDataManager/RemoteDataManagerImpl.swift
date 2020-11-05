//
//  RemoteDataManagerImpl.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

let apiURL = "https://api.brewerydb.com/v2"

class RemoteDataManagerImpl: RemoteDataManager {
    var baseURL: URL {
        guard let baseURL = URL(string: apiURL) else {
            fatalError("URL not valid")
        }
        return baseURL
    }
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    var parameters: [String: String] {
        return [
            "key":"40759fb26d1c95525eccb893e9c7e06c"
        ]
    }
    
    func getBeers(completion: @escaping (Result<[Beer]?, CustomError>) -> Void) {
        let url = baseURL.appendingPathComponent("/beers")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
        guard let finalUrl = components?.url else { return }
        let request = URLRequest(url: finalUrl)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
        if let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
            DispatchQueue.main.async {
                if httpResponse.statusCode == 401 {
                    completion(.failure(.unauthorized))
                } else if let err = error {
                    completion(.failure(.networkError(err)))
                }
            }
        }
            
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                
                do {
                    let beersResponse = try JSONDecoder().decode(BeersResponse.self, from: data)
                    
                    let beers = beersResponse.data.map {
                        Beer(id: $0.id,
                             name: $0.style?.name ?? "No beer name",
                             description: $0.style?.description ?? "No beer description",
                             category: $0.style?.category.name ?? "No category name",
                             categoryId: $0.style?.category.id ?? 0,
                             imageUrl: $0.labels?.medium ?? " ")
                    }
                    DispatchQueue.main.async {
                        completion(.success(beers))
                    }
                } catch (let error) {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError(error)))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.emptyResponse))
                }
            }
        }
        dataTask.resume()
    }
    
    func getBeer(id: String, completion: @escaping (Result<Beer?, CustomError>) -> Void) {
        let url = baseURL.appendingPathComponent("/beers/\(id)")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
        guard let finalUrl = components?.url else { return }
        let request = URLRequest(url: finalUrl)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
        if let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
            DispatchQueue.main.async {
                if httpResponse.statusCode == 401 {
                    completion(.failure(.unauthorized))
                } else if let err = error {
                    completion(.failure(.networkError(err)))
                }
            }
        }
            
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                
                do {
                    let apiBeerResponse = try JSONDecoder().decode(ApiBeer.self, from: data)
                    let beer = Beer(id: apiBeerResponse.id,
                                    name: apiBeerResponse.style?.name ?? "No beer name",
                                    description: apiBeerResponse.style?.description ?? "No beer description",
                                    category: apiBeerResponse.style?.category.name ?? "No category name",
                                    categoryId: apiBeerResponse.style?.category.id ?? 0,
                                    imageUrl: apiBeerResponse.labels?.medium ?? " ")
                    DispatchQueue.main.async {
                        completion(.success(beer))
                    }
                } catch (let error) {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError(error)))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.emptyResponse))
                }
            }
        }
        dataTask.resume()
    }
    
    func getBeerCategories(completion: @escaping (Result<[BeerCategory]?, CustomError>) -> Void) {
        
        let url = baseURL.appendingPathComponent("/categories")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
        guard let finalUrl = components?.url else { return }
        let request = URLRequest(url: finalUrl)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 401 {
                        completion(.failure(.unauthorized))
                    } else if let err = error {
                        completion(.failure(.networkError(err)))
                    }
                }
            }
            
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                
                do {
                    let categoriesResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(categoriesResponse.data))
                    }
                } catch (let error) {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError(error)))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.emptyResponse))
                }
            }
        }
        dataTask.resume()
    }
}
