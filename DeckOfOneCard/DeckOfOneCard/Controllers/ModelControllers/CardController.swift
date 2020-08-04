//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Ian Becker on 8/4/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation
import UIKit

class CardController {
    
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        // 1 - Prepare URL
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1") else {return completion(.failure(.invalidURL))}
        print(url)
        // 2 - Contact server
        URLSession.shared.dataTask(with: url) {data, _, error in
            // 3 - Handle errors from the server
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            // 4 - Check for json data
            guard let data = data else {return completion(.failure(.noData))}
            // 5 - Decode json into a Card
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else {return completion(.failure(.noData))}
                return completion(.success(card))
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        // 1 - Prepare URL
        let url = card.image
        // 2 - Contact Server
        URLSession.shared.dataTask(with: url) {data, _, error in
            // 3 - Handle errors from the server
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            // 4 - Check for image data
            guard let imageData = data else {return completion(.failure(.noData))}
            // 5 - Initialize an image from the data
            guard let cardImage = UIImage(data: imageData) else {return completion(.failure(.unableToDecode))}
            return completion(.success(cardImage))
        }.resume()
    }
}
