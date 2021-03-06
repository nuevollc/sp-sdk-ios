//
//  MockNetworkService.swift
//  ZenKeySDK
//
//  Created by Adam Tierney on 2/25/19.
//  Copyright © 2019 ZenKey, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
@testable import ZenKeySDK

class MockNetworkService: NetworkServiceProtocol {
    private var mockJSON: [String: Any]?
    private var mockError: NetworkServiceError?

    var lastRequest: URLRequest?

    func mockJSON(_ json: [String: Any]) {
        mockError = nil
        mockJSON = json
    }

    func mockError(_ error: NetworkServiceError) {
        mockJSON = nil
        mockError = error
    }

    func clear() {
        lastRequest = nil
        mockError = nil
        mockJSON = nil
    }

    let jsonDecoder = JSONDecoder()

    func requestJSON<T>(
        request: URLRequest,
        completion: @escaping (Result<T, NetworkServiceError>) -> Void) where T: Decodable {

        self.lastRequest = request
        let mockJSON = self.mockJSON
        let mockError = self.mockError
        let decoder = jsonDecoder
        DispatchQueue.main.async {
            if let mockJSON = mockJSON {
                guard let data = try? JSONSerialization.data(withJSONObject: mockJSON, options: []) else {
                    fatalError("unable to parse mock json, check your mocks")
                }

                let parsed: Result<T, NetworkServiceError> = NetworkService.JSONResponseParser
                    .parseDecodable(
                        with: decoder,
                        fromData: data,
                        request: request,
                        error: nil
                )

                completion(parsed)
            }

            if let mockError = mockError {
                completion(.failure(mockError))
            }
        }
    }
}
