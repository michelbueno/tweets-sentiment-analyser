//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Alamofire

protocol RemoteServiceType {
    func get(url: URL, headers: HTTPHeaders, onSuccess: @escaping (Data?) -> Void, onFailure: @escaping () -> Void)
    func post(url: URL, parameters: [String: Any], onSuccess: @escaping (Data?) -> Void, onFailure: @escaping () -> Void)
}

class RemoteService: RemoteServiceType {
    func get(url: URL, headers: HTTPHeaders, onSuccess: @escaping (Data?) -> Void, onFailure: @escaping () -> Void) {
        AF.request(url, headers: headers).responseJSON { response in
            if response.response?.statusCode == 200 {
                onSuccess(response.data)
            } else {
                onFailure()
            }
        }
    }

    func post(url: URL, parameters: [String: Any], onSuccess: @escaping (Data?) -> Void, onFailure: @escaping () -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if response.response?.statusCode == 200 {
                onSuccess(response.data)
            } else {
                onFailure()
            }
        }
    }
}
