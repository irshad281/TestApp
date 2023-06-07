//
//  ViewModel.swift
//  TestApp
//
//  Created by Irshad Ahmad on 07/06/23.
//

import Foundation
import Combine

final class ViewModel {
    var jokes = [String]()
    private var objectIndex: Int = 0
    var refreshView = CurrentValueSubject<Bool, Never>(false)
    
    init() {
        jokes.reserveCapacity(10)
        jokes = PersistantManager.fetchJokes()
        fetchJoke()
        startTimer()
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { timer in
            self.fetchJoke()
        }
    }
}

// MARK: - Service

extension ViewModel {
    private func fetchJoke() {
        JokeService.fetchJoke { joke in
            if self.jokes.count != 10 {
                self.jokes.append(joke)
            } else {
                if self.objectIndex == 9 {
                    self.jokes[self.objectIndex] = joke
                    self.objectIndex = 0
                } else {
                    self.jokes[self.objectIndex] = joke
                    self.objectIndex += 1
                }
            }
            self.refreshView.send(true)
            PersistantManager.saveJokes(self.jokes)
        }
    }
}
