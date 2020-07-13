//
//  NetworkManager.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
import Alamofire

public typealias VFGNetworkCompletion = ( Codable?, Error? ) -> Void
/// Api Manager
class NetworkManager {

    static let shared: NetworkManager = NetworkManager()

    private init(){
    }
    func execute<T: Codable>(url: String,
                                   method: HTTPMethod,
                                   encoding: ParameterEncoding = URLEncoding.default,
                                   paramter: [String: Any],
                                   header: HTTPHeaders? = nil,
                                   completion: @escaping (T)-> Void) {
        Alamofire.request( APIConfig.URL + url, method: method, parameters: paramter, encoding: encoding, headers: header).responseJSON { (responseObject) -> Void in
            print( "url ==> ", APIConfig.URL + url)
            print(responseObject)

            if responseObject.result.isSuccess  {
                // TODO fetch error from response
                // if  300 > responseObject.response?.statusCode > = 200
                do {
                    guard let data = responseObject.data else {
                        throw GroceryError.FoundNil("no data")
                    }
                    guard let response = try? JSONDecoder().decode(T.self, from: data) else {

                        throw GroceryError.FoundNil("decoding fail")
                    }
                    completion(response)

                } catch let error {
                    print(error)
                }
            }
        }
    }
}
