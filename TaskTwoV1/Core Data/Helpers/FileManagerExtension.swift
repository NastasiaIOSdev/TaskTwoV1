//
//  FileManagerExtensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 04.08.2021.
//

import Foundation

extension FileManager {

    static var documentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask)[0]
    }
}
