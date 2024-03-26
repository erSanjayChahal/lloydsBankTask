//
//  HomeViewModel.swift
//  lloydsBank
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation
import Combine

@Observable final class HomeViewModel {
    private var cancellables = Set<AnyCancellable>()

     var moviesList: [Movie] = []
     var error: CustomErrorProtocol? = nil
     var isLoading = false

    
    let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchMovies() {
        isLoading = true
        error = nil
        
        let apiData = MoviesApiData()
        apiManager.fetch(apiData)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    print("Request completed successfully")
                case .failure(let error):
                    self.error = error
                }
        }, receiveValue: {[weak self] model in
            self?.moviesList = model
        }).store(in: &cancellables)
    }
}
