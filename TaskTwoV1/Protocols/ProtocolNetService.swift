//
//  ProtocolNetService.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 04.07.2021.
//

import Foundation

protocol NetService {

    func getBreed(completion: @escaping (Result<[Breed], Error>) -> Void)
    func getPeopleList(completion: @escaping (Result<[Results], Error>) -> Void)
    func searchPeopleList(with query: String, completion: @escaping (Result<[Results], Error>) -> Void)
}
