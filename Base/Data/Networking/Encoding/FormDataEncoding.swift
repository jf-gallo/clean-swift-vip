//
//  FormDataEncoding.swift
//
//  Created by Juan Felipe Gallo on 9/21/19.
//  Copyright © 2019 jogo. All rights reserved.
//

import Foundation

 struct FormDataParameterEncoder: ParameterEncoder {
    
     static func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) {
        
        let parameters = parameters.getQueryString
        
        urlRequest.httpBody = parameters.data(using:String.Encoding.utf8, allowLossyConversion: false)
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
