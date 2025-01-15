//
//  LocalFileManager.swift
//  V2EX
//
//  Created by kim on 2024/11/22.
//

import Foundation
import SwiftUI
import Combine

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // create folder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName) else {
            return
        }
        
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. ImageName: \(imageName). \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path(percentEncoded: true)) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path(percentEncoded: true))
    }
    
    func clearCache(folderName: String? = nil) -> Future<Bool, Never> {
        return Future { promise in
            if let folderName = folderName {
                // clear specific folder
                guard let folderURL = self.getURLForFolder(folderName: folderName) else {
                    promise(.success(false))
                    return
                }
                do {
                    try FileManager.default.removeItem(at: folderURL)
                    promise(.success(true))
                    print("Successfully cleared folder: \(folderName)")
                } catch {
                    promise(.success(false))
                    print("Error clearing folder. FolderName: \(folderName). \(error)")
                }
            } else {
                // clear all cache directory
                guard let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                    promise(.success(false))
                    return
                }
                do {
                    let contents = try FileManager.default.contentsOfDirectory(at: cacheURL, includingPropertiesForKeys: nil)
                    for fileURL in contents {
                        try FileManager.default.removeItem(at: fileURL)
                    }
                    promise(.success(true))
                    print("Successfully cleared all cache")
                } catch {
                    promise(.success(false))
                    print("Error clearing cache. \(error)")
                }
            }
        }
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path(percentEncoded: true)) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory. FolderName: \(folderName). \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appending(path: folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let url = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return url.appending(path: imageName + ".png")
    }
}
