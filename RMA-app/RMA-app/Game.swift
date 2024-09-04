//
//  Game.swift
//  RMA-app
//
//  Created by student on 23.01.2024..
//

import Foundation
import UIKit

struct Game: Identifiable, Codable {
    var id = UUID().uuidString
    let gameName: String
    let imgURL: URL
    var isSaved: Bool
    //var levels: [Level]
}

/*func loadImage(from game: Game) -> UIImage? {
    do {
        let imgData = try Data(contentsOf: game.imgURL)
        return UIImage(data: imgData)
    } catch {
        print("Error loading image: \(error)")
        return nil
    }
}*/
func loadImageAsync(from url: URL, completion: @escaping (UIImage?) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error loading image: \(error)")
            completion(nil)
            return
        }

        guard let data = data else {
            completion(nil)
            return
        }

        let image = UIImage( data: data)
        completion(image)
    }

    task.resume()
}
