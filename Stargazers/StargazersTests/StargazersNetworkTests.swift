//
//  StargazersTests.swift
//  StargazersTests
//
//  Created by Alessio Quattrocchi on 20/11/22.
//

import XCTest
import Moya

@testable import Stargazers

class StargazersNetworkTests: XCTestCase {
    //Mark:- 404 | 500 | 200 GitHubAPI
    func testGitHubAPIRepoNotFound() {
        let stubProvider = stubGithubProvider(response: .networkResponse(404, "".data(using: .utf8)!))
        let stargazerClient = StargazerClient(provider: stubProvider)
        let testExpectation = expectation(description: "404")
        
        stargazerClient.stargazers(owner: "Test", repo: "Test", perPage: 1, page: 1) { result in
            XCTAssertEqual(Result.failure(StargazerServiceError.repositoryNotFound), result)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 5.0)
    }
    
    func testGitHubAPIGenericError() {
        let stubProvider = stubGithubProvider(response: .networkResponse(500, "".data(using: .utf8)!))
        let stargazerclient = StargazerClient(provider: stubProvider)
        let testExpectation = expectation(description: "404")
        
        stargazerclient.stargazers(owner: "Test", repo: "Test", perPage: 1, page: 1) { result in
            XCTAssertEqual(Result.failure(StargazerServiceError.genericError), result)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 5.0)
    }
    
    func testGitHubAPISuccess() {
        let stubProvider = stubGithubProvider(response: .networkResponse(200, self.validJsonResponse.data(using: .utf8)!))
        let stargazerClient = StargazerClient(provider: stubProvider)
        let testExpectation = expectation(description: "200")
        let expectedStargazerList = [Stargazer(id: 12029068, name: "aleUnix", avatarUrl: "https://avatars.githubusercontent.com/u/12029068?v=4")]
        
        stargazerClient.stargazers(owner: "Test", repo: "Test", perPage: 1, page: 1) { result in
            XCTAssertEqual(Result.success(expectedStargazerList), result)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 5.0)
    }

    
    private func stubGithubProvider(response: EndpointSampleResponse) -> MoyaProvider<StargazerNetwork> {
        MoyaProvider<StargazerNetwork>(endpointClosure: customEndpointClosure(response: response), stubClosure: MoyaProvider.immediatelyStub)
    }

    private func customEndpointClosure(response: EndpointSampleResponse) -> ((StargazerNetwork) -> Endpoint) {
        { (target: StargazerNetwork) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { response },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
    }
    
    private let validJsonResponse = """
        [
          {
            "login": "aleUnix",
            "id": 12029068,
            "node_id": "MDQ6VXNlcjU2OTI2OQ==",
            "avatar_url": "https://avatars.githubusercontent.com/u/12029068?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/aleUnix",
            "html_url": "https://github.com/aleUnix",
            "followers_url": "https://api.github.com/users/aleUnix/followers",
            "following_url": "https://api.github.com/users/aleUnix/following{/other_user}",
            "gists_url": "https://api.github.com/users/aleUnix/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/aleUnix/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/aleUnix/subscriptions",
            "organizations_url": "https://api.github.com/users/aleUnix/orgs",
            "repos_url": "https://api.github.com/users/aleUnix/repos",
            "events_url": "https://api.github.com/users/aleUnix/events{/privacy}",
            "received_events_url": "https://api.github.com/users/aleUnix/received_events",
            "type": "User",
            "site_admin": false
          }
        ]
    """
    
}
