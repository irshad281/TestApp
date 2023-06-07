//
//  JokeService.swift
//  TestApp
//
//  Created by Irshad Ahmad on 07/06/23.
//

import Foundation

struct JokeService {
    static func fetchJoke(completion: ((String) -> Void)?) {
        guard let url = URL(string: "https://geek-jokes.sameerkumar.website/api") else {
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let string = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    completion?(string)
                }
            }
        }.resume()
    }
}
