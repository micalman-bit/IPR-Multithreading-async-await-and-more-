//
//  Webservice.swift
//  Webservice
//
//  Created by Andrey Samchenko
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidImageId(Int)
    case decodingError
}

class Webservice {
    
    func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
        
        var randomImages: [RandomImage] = []
        
        
        for id in ids {
            let randomImage = try await getRandomImage(id: id)
            randomImages.append(randomImage)
        }
        
        try await withThrowingTaskGroup(of: (Int, RandomImage).self, body: { group in
            
            for id in ids {
                group.async {
                    return (id, try await self.getRandomImage(id: id))
                }
            }
            
            
            for try await (_, randomImage) in group {
                print(randomImage)
                randomImages.append(randomImage)
            }
            
        })
         
       
        return randomImages
        
    }
    
    func getRandomImage(id: Int) async throws -> RandomImage {
        
        guard let url = Constants.Urls.getRandomImageUrl() else {
                   throw NetworkError.badUrl
        }
        
        guard let randomQuoteUrl = Constants.Urls.randomQuoteUrl else {
                   throw NetworkError.badUrl
        }
        
        async let (imageData, _) = URLSession.shared.data(from: url)
        async let (randomQuoteData, _) = URLSession.shared.data(from: randomQuoteUrl)
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await randomQuoteData) else {
            throw NetworkError.decodingError
        }
        
        return RandomImage(image: try await imageData, quote: quote)
    }
    
}
