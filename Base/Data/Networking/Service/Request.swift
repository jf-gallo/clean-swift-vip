//
//  NetworkRequester.swift
//
//  Created by Juan Felipe Gallo on 8/31/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

struct WebServiceRequest<T: Codable> {
    
    struct Dependencies {
        let parser: JSONSerializer = JSONSerializer()
        let decoder: JSONDecoder = .init()
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
    
    private let router = Router<WebServiceAdapter>()
    
    enum Result {
        case success
        case failure(String)
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return.failure(NetworkResponse.failed.rawValue)
        }
    }
}

extension WebServiceRequest {
    
    func makeRequest(for route: WebServiceAdapter, completion: @escaping serviceCompletion<T>) {
        router.request(route) { (data, response, error) in
            
            if error != nil {
                completion(.failure("Request failed timeut"))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                    
                case .success:
                    guard let responseData = data, responseData.count != 0 else {
                        print(NetworkResponse.noData.rawValue)
                        completion(.success(nil))
                        return
                    }
                    do {
                        guard !self.dependencies.parser.isArrayData(data: data) else {
                            
                            let arrayDict = self.dependencies.parser.JSONizeArrayResponse(data: data)
                            let response: [T]? = arrayDict?.compactMap {  value in
                                print(value)
                                return T.parse(from: value)?.first
                            }
                            
                            let apiResponse = try self.dependencies.decoder.decode([T].self, from: responseData)
                            completion(.success(apiResponse))
                            return
                        }
                        
                        self.dependencies.parser.JSONizeSingleResponse(data: data)
                        
                        let apiResponse = try self.dependencies.decoder.decode(T.self, from: responseData)
                        completion(.success([apiResponse]))
                        
                    } catch {
                        print(NetworkResponse.unableToDecode.rawValue)
                        completion(.success(nil))
                    }
                case .failure(let networkResponseError):
                    completion(.failure(networkResponseError))
                }
            }
        }
    }
}

