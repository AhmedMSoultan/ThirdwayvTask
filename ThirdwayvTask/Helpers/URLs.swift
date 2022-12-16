//
//  URLs.swift
//  ThirdwayvTask
//
//  Created by Ahmed Soultan on 14/12/2022.
//

import Foundation

let baseURL = "https://api.jsonserve.com/KhDs5B"

enum EndPoint: Equatable {
    // MARK: - Home
    case home

    var url: URL {
        return URL(string: self.urlValue) ?? URL(string: "")!
    }

    var urlValue: String {
        switch self {
            // MARK: - Home
        case .home:
            return baseURL
        }
    }
}
