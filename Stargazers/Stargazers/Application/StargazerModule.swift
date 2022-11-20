//
//  StargazerModule.swift
//  Stargazers
//
//  Created by Alessio Quattrocchi on 20/11/22.
//

import Moya
import Foundation
import UIKit

class StargazerModule {
   
    func createStargazerViewController() -> UIViewController {
        let viewController = StargazersListViewController.initialize(on: .main)
        viewController.viewModel = createStargazerViewModel()
        return viewController
    }
    
    private func createStargazerViewModel() -> StargazerViewModel {
        let viewModel = StargazerViewModel(service: createStargazerService(), cellViewModels: [])
        return viewModel
    }
    
    private func createStargazerService() -> StargazerClient {
        let service = StargazerClient(provider: MoyaProvider<StargazerNetwork>())
        return service
    }
}
