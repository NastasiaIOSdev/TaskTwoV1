//
//  APICaller.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.06.2021.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let breedsURL = URL(string: "https://api.thecatapi.com/v1/breeds")
    }
    
    private init() {}
    
    func getBreed(completion: @escaping (Result<Breed, Error>) -> Void) {
        guard let url = Constants.breedsURL else {
            return
    }
    let task = URLSession.shared.dataTask(with: url) { data,_,error in
        if let error = error {
            completion(.failure(error))
        }
        else if let data = data {
            do {
                let result = try JSONDecoder().decode(Breed.self, from: data)
                print("Country:\(result.origin.count)")
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
// MARK: - Model

struct Breed: Codable {
    var name: String
    var origin: String
    var image: Image?
}

struct Image: Codable {
    var url: String?
}
