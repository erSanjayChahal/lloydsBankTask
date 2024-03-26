//
//  AppCoordinator.swift
//  lloydsBankTest
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation
import UIKit
import SwiftUI

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? {get set}
    var children: [Coordinator]? { get set}
    var navigationController: UINavigationController { get set}
}
final class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator]?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let contentView = HomeView()
        let rootView = UIHostingController(rootView: contentView)
        navigationController.pushViewController(rootView, animated: true)
    }
}
