//
//  ErrorView.swift
//  lloydsBank
//
//  Created by Sanjay Chahal on 24/03/24.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Error Occurred")
                .font(.headline)
                .foregroundColor(.red)
            
            Text(error.localizedDescription)
                .foregroundColor(.gray)
                .padding()
            
            Button(action: {
                // Retry action
                retryAction()
            }) {
                Text("Retry")
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
    }
}
