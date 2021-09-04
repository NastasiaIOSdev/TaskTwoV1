//
//  FileManagerDoExtension.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 04.08.2021.
//

import Foundation

extension MainUIViewController {

    func fileManagerWork() {

        let fileManager = FileManager.default
        let cachesDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let tmpDir = fileManager.temporaryDirectory
        print(cachesDir ?? "")
        print(docDir ?? "")
        print(tmpDir)
        let txtFileUrl = tmpDir.appendingPathComponent("TestFile.txt")
        let isFileExists = fileManager.fileExists(atPath: txtFileUrl.path)
        if isFileExists {
            do {
                let text = try String(contentsOfFile: txtFileUrl.path)
                print(text)
            } catch {
                print(error)
            }

        } else {
            let data = "Hello world!".data(using: .utf8)
            fileManager.createFile(atPath: txtFileUrl.path,
                                   contents: data,
                                   attributes: nil)
        }
        do {
            try fileManager.removeItem(atPath: txtFileUrl.path)
        } catch {
            print(error)
        }
    }
}
