//
//  NetworkHelper.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation


// Todo:- handle all failuer and errors in webservice
protocol HandleErrors {
    func handleError(error: String)
    func handleFailuer()
}

//
enum GroceryError: Error {
    case FoundNil(String)
}
