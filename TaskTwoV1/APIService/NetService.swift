//
//  NetService.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 30.06.2021.
//

import Foundation

protocol NetService {
    func getBreed(completion: @escaping (Result<[Breed], Error>) -> Void)
}

final class APIService {
    static let shared = APIService()
    struct Constants {
        static let breedsURL = URL(string: "https://api.thecatapi.com/v1/breeds")
    }
    private init() {}
    
    func getBreed(completion: @escaping (Result<[Breed], Error>) -> Void) {
        guard let url = Constants.breedsURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data,_,error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode([Breed].self, from: data)
                    print("Country:\(result.count)")
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        
    }
}
