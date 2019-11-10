//
//  Router.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 10/11/19.
//

import Foundation
import Alamofire

enum ReposRouter: RouterConfig {
    
    case getRepos(page: Int)
    case getPulls(owner: String, repo: String)
    
    var endPoint: String {
        switch self {
        case .getRepos(let page):
            return "search/repositories?q=language:Swift&sort=stars&page=\(page)"
        case .getPulls(let owner, let repo):
            return "repos/\(owner)/\(repo)/pulls"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var urlWithParams: String {
        return ""
    }
    
    var params: APIParams {
        return nil
    }
    
    var headers: APIHeaders {
        return [
            "Content-Type": "application/json; charset=UTF-8"
        ]
        
    }
    
}

