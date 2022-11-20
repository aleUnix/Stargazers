//
//  StargazersListCellViewModel.swift
//  Stargazers
//
//  Created by Alessio Quattrocchi on 20/11/22.
//

import Foundation

struct StargazersListCellViewModel: Equatable {
    let avatar_url: String?
    let login: String?
}

extension StargazersListCellViewModel {
    init(stargazer: Stargazer) {
        self.avatar_url = stargazer.avatarUrl
        self.login = stargazer.name 
    }
}
