//
//  Router.swift
//  jogo-ios
//
//  Created by Juan Felipe Gallo on 8/30/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

class Router<EndPoint: WebService>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping networkRouterCompletion) {
        
        let session = URLSession.shared
    
        do {
            let request = try self.buildRequest(from: route)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if response != nil { NetworkLogger.log(response: response!) }
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest.init(url: route.baseURL.appendingPathComponent(route.path),
                                      cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                      timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             bodyFormData: bodyParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let urlParameters,
                                              let bodyFormData,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             bodyFormData: bodyFormData,
                                             request: &request)
            default:
                assertionFailure("Should this one default?")
            }
            
            return request
        }
    }
    
    fileprivate func configureParameters(bodyParameters: RequestParameters?,
                                         urlParameters: RequestParameters?,
                                         bodyFormData: RequestParameters?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
            if let bodyFormData = bodyFormData {
                  FormDataParameterEncoder.encode(urlRequest: &request, with: bodyFormData)
            }
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
