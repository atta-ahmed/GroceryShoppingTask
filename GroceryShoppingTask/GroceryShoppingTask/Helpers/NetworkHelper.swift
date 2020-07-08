//
//  NetworkHelper.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
import Alamofire

class NetworkHelper {

    static var delegate: HandleErrors!

    class func request<T: Codable >(url: String , success: @escaping (T) -> Void, method: HTTPMethod, paramter: [String: Any] ){

        Alamofire.request( GroceryAPIConfig.URL + url , method: method, parameters: paramter, encoding: URLEncoding.default , headers: nil).responseJSON { (responseObject) -> Void in
            print( "url ==> ", GroceryAPIConfig.URL + url)
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
                    success(response)

                } catch let error {

                    print(error)
                }

            } else if responseObject.result.isFailure {
                delegate?.handleFailuer()

            } else {
                delegate?.handleError(error: "server error") //TODO fetch error from responce
            }
        }
    }

}

// will handle all failuer and errors in webservice
protocol HandleErrors {
    func handleError(error: String)
    func handleFailuer()
}

enum GroceryError: Error {
    case FoundNil(String)
}
