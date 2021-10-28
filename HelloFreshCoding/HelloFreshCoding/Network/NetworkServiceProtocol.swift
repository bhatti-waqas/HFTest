//
//  NetworkServiceProtocol.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

typealias ResultHandler<T> = (Result<T, Error>) -> Void

protocol NetworkServiceProtocol: AnyObject {
    //func fetch<T:Decodable>(_ url: String, completion: @escaping (Result<T, Error>) -> Void)
    func fetch<T:Decodable>(_ url: String, completion: @escaping ResultHandler<T>)
}
