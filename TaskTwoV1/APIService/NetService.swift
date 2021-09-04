//
//  NetService.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 30.06.2021.
//

import Foundation
import CoreData
import UIKit

final class APIService {

    static let shared = APIService()

    init() {}

    // MARK: - Cats

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

    // MARK: - CatsPhoto

    public func getPhotos(breedId: String, completed: @escaping (Result<[CatImage], Error>) -> Void) {
        let urlString = "https://api.thecatapi.com/v1/images/search?breed_id=\(breedId)&limit=\(100)"
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completed(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode([CatImage].self, from: data)
                    completed(.success(result))
                } catch {
                    completed(.failure(error))
                }
            }
        }
        task.resume()
    }

    // MARK: - StarWars

    public func searchPeopleList(with text: String, completion: @escaping (Result<[Results], Error>) -> Void) {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlstring = "https://swapi.dev/api/people/?search=\(text)&format=json"

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

    // MARK: - DogsList

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
        }
        task.resume()
    }

    // MARK: - DogsPhoto

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
        }
        task.resume()
    }

    public func getPhotoHound(_ hound: String, completed: @escaping (Result<ImageHound, Error>) -> Void) {
        let urlString = "https://dog.ceo/api/breed/\(hound)/images"
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completed(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(ImageHound.self, from: data)
                    completed(.success(result))
                } catch {
                    completed(.failure(error))
                }
            }
        }
        task.resume()
    }

    // MARK: - News

    func getSourceFilters(completion: @escaping ([SourceFilter], Error?) -> Void) {
        guard var url: URLComponents = URLComponents(url: NewsEndPoints.Endpoints.sourceFilters.url, resolvingAgainstBaseURL: true) else {
            print("An error with URL convertation has occured")
            return
        }
        url.queryItems = [URLQueryItem(name: "apiKey", value: Constants.apiKeyNews), URLQueryItem(name: "language", value: "en")]
        NetworkingTasks.taskForRequest(url: url.url!, responseType: SourceFilterResponse.self) { (response, error) in
            guard let sourceFilters = response?.sources else {
                completion([], error)
                return
            }
            completion(sourceFilters, nil)
        }
    }

    func getNewsInfo(currentPage: Int, pageSize: Int, filters: [String: [String]], searchQuery: String, completion: @escaping (NewsInfo?, Error?) -> Void) {
        guard var url: URLComponents = URLComponents(url: NewsEndPoints.Endpoints.topHeadlines.url, resolvingAgainstBaseURL: true) else {
            print("An error with URL convertation has occured")
            return
        }
        url.queryItems = [
            URLQueryItem(
                name: "apiKey",
                value: Constants.apiKeyNews
            ),
            URLQueryItem(
                name: "page",
                value: "\(currentPage)"
            ),
            URLQueryItem(
                name: "language",
                value: "en"
            ),
            URLQueryItem(
                name: "pageSize",
                value: "\(pageSize)"
            )
        ]
        if searchQuery.isEmpty {
            for filterType in FilterType.asArray {
                if let chosenFilteroptions = filters[filterType.rawValue] {
                    let filterName = filterType.rawValue.lowercased() == "source" ? "sources" : filterType.rawValue.lowercased()
                    url.queryItems?.append(URLQueryItem(name: filterName, value: chosenFilteroptions.joined(separator: ",")))
                }
            }
        } else { url.queryItems?.append(URLQueryItem(name: "q", value: searchQuery)) }
        NetworkingTasks.taskForRequest(url: url.url!, responseType: NewsInfo.self) { (response, error) in
            completion(response, error)
        }
    }

}
