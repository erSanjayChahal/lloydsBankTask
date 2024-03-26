//
//  HomeView.swift
//  lloydsBank
//
//  Created by Sanjay Chahal on 24/03/24.
//

import SwiftUI

struct HomeView: View {
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel = HomeViewModel(apiManager: APIManager())) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.error {
                ErrorView(error: error, retryAction: {
                    viewModel.fetchMovies()
                })
            } else {
                List(viewModel.moviesList) { movie in
                    MovieCell(movie: movie)
                        .frame(height: 200)
                }
            }
        }
        .onAppear {
            viewModel.fetchMovies()
        }
        .refreshable {
            viewModel.fetchMovies()
        }
        .navigationBarTitle("Movies List")
    }
}


struct MovieCell: View {
    let movie: Movie
    struct Constants {
        static let imageWidth: CGFloat = 100
        static let imageHeight: CGFloat = 200
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.imageUrl)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                case .empty:
                    ProgressView() // Placeholder for loading
                        .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                @unknown default:
                    EmptyView()
                }
            }
            .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.subtitle)
                    .font(.subheadline)
                Text(movie.description)
                    .font(.body)
            }
            .padding(.leading, 8)
        }
    }
}

#Preview {
    HomeView()
}
