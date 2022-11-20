//
//  StargazerhubService.swift
//  Stargazers
//
//  Created by Alessio Quattrocchi on 20/11/22.
//

import Moya

protocol StargazerService {
    func stargazers(owner: String, repo: String, perPage: Int, page: Int, completion: @escaping (Result<[Stargazer], StargazerServiceError>) -> Void)
    
}

class StargazerClient: StargazerService {
    
    private let provider: MoyaProvider<StargazerNetwork>
    
    init (provider: MoyaProvider<StargazerNetwork>) {
        self.provider = provider
    }
    
    func stargazers(owner: String, repo: String, perPage: Int, page: Int, completion: @escaping (Result<[Stargazer], StargazerServiceError>) -> Void) {
        provider.request(.stargazers(owner: owner, repo: repo, perPage: perPage, page: page)) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    guard let list: [Stargazer] = try? response.map([Stargazer].self) else {
                        completion(.failure(.genericError))
                        return
                    }
                    completion(.success(list))
                case 404:
                    completion(.failure(.repositoryNotFound))
                default: completion(.failure(.genericError))
                }
            case .failure:
                completion(.failure(.genericError))
            }
        }
    }
}

enum StargazerServiceError: Error {
    case repositoryNotFound
    case genericError
    
    var errorDescription: String {
        get {
            switch self {
            case .genericError: return "An error occurred, retry later..."
            case .repositoryNotFound: return "Repository not found"
            }
        }
    }
}

