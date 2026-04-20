//
//  AlamofireImageLoaderService.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Alamofire
import UIKit
import UIKitComponent

enum ImageLoaderError: Error {
    case invalidResponse
}

final class AlamofireImageLoaderService: ImageLoader {
    private let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
        return cache
    }()
    
    func fetchImage(for url: String, cacheKey: String) async throws -> UIImage {
        if let cachedImage = cache.object(forKey: NSString(string: cacheKey)) {
            return cachedImage
        }
        
        let imageData = try await AF.request(
            url,
            method: .get,
            headers: [
                "X-Api-Key": ApiConfig.getApiKey() ?? "",
                "Accept": "image/jpg"
            ]
        )
        .validate()
        .serializingData()
        .value
        
        guard let image = UIImage(data: imageData) else {
            throw ImageLoaderError.invalidResponse
        }
        
        cache.setObject(image, forKey: NSString(string: cacheKey))
        return image
    }
}
