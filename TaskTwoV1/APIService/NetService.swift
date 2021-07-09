//
//  NetService.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 30.06.2021.
//

import Foundation

final class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    public func getBreed(completion: @escaping (Result<[Breed], Error>) -> Void) {
        guard let url = Constants.breedsURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode([Breed].self, from: data)
                    print("Country:\(result.count)")
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        
    }
    
    public func getPeopleList(completion: @escaping (Result<[Results], Error>) -> Void) {
        guard let url = Constants.peopleURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("People: \(String(describing: result.results.count))")
                    completion(.success(result.results ))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func searchPeopleList(with query: String, completion: @escaping (Result<[Results], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlstring = Constants.searchURLString + query
        
        guard let url = URL(string: urlstring) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("People: \(result.results.count)")
                    completion(.success(result.results ))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    public func getBreed2(completed: @escaping (Result<Breed2, Error>) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/list") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completed(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Breed2.self, from: data)
                    completed(.success(result))
                } catch {
                    completed(.failure(error))
                }
            }
        }.resume()
    }
    public func getPhoto(breeds: String, completed: @escaping (Result<Image2, Error>) -> Void) {
        let urlString = "https://dog.ceo/api/breed/\(breeds)/images/random"
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completed(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Image2.self, from: data)
                    completed(.success(result))
                } catch {
                    completed(.failure(error))
                }
            }
        }.resume()
    }
}
