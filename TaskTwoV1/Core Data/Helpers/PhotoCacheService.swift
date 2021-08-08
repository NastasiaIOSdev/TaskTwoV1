//
//  PhotoCatcheService.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 04.08.2021.
//

import Foundation
import UIKit

class PhotoCacheService {

    private let cacheLifeTime: TimeInterval = 24 * 60 * 60

    private static let pathName: String = {
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return pathName
        }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoCacheService.pathName + "/" + hashName).path
    }

    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }

    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }

        let lifeTime = Date().timeIntervalSince(modificationDate)

        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }

        DispatchQueue.main.async {
            self.images[url] = image
        }

        return image
    }

    private var images = [String: UIImage]()

    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self.images[urlString] = image
            }
            self.saveImageToCache(url: urlString, image: image)
            DispatchQueue.main.async {
                self.container.reloadRow(atIndexpath: indexPath, image: image)
            }
        }).resume()
    }

    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }

    private let container: DataReloadable

    init(container: UITableView) {
        self.container = Table(table: container)
    }

    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    init(container: UIImageView) {
        self.container = ImageView(imageView: container)
    }
}

private protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath, image: UIImage)
}

extension PhotoCacheService {

    private class Table: DataReloadable {
        let table: UITableView
        init(table: UITableView) {
            self.table = table
        }

        func reloadRow(atIndexpath indexPath: IndexPath, image: UIImage) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }

    private class Collection: DataReloadable {
        let collection: UICollectionView
        init(collection: UICollectionView) {
            self.collection = collection
        }

        func reloadRow(atIndexpath indexPath: IndexPath, image: UIImage) {
            collection.reloadItems(at: [indexPath])
        }
    }
    
    private class ImageView: DataReloadable {
        let imageView: UIImageView
        init(imageView: UIImageView) {
            self.imageView = imageView
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath, image: UIImage) {
            self.imageView.image = image
        }
    }
}
