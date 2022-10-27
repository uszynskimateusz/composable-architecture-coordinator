//
//  User.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import ComposableArchitecture
import Foundation

struct User: Equatable {
    let name: String
}

struct UserResponse: Decodable, Equatable {
    let results: [UserName]
}

struct UserName: Decodable, Equatable {
    let first: String
}

func userEffext(decoder: JSONDecoder) -> Effect<UserResponse, APIError> {
    guard let url = URL(string: "https://randomuser.me/api/?inc=name") else {
        fatalError("Error on creating url")
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .mapError { _ in APIError.downloadError }
        .map { data, _ in data }
        .decode(type: UserResponse.self, decoder: decoder)
        .mapError { _ in APIError.decodingError }
        .eraseToEffect()
}

func dummyUserEffext(decoder: JSONDecoder) -> Effect<UserResponse, APIError> {
    let dummyUser = UserResponse(results: [UserName(first: "John")])
    return Effect(value: dummyUser)
}
