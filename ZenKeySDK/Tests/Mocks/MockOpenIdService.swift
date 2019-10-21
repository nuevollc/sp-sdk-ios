//
//  MockOpenIdService.swift
//  ZenKeySDK
//
//  Created by Adam Tierney on 5/30/19.
//  Copyright © 2019 XCI JV, LLC. All rights reserved.
//

import UIKit
@testable import ZenKeySDK

class MockOpenIdService: OpenIdServiceProtocol {

    static let mockSuccess = AuthorizedResponse(code: "abc123", mcc: "123", mnc: "456", redirectURI: URL.mocked)
    var lastParameters: OpenIdAuthorizationRequest.Parameters?
    var lastCompletion: OpenIdServiceCompletion?
    var lastViewController: UIViewController?

    var holdCompletionUntilURL: Bool = false
    var lastURL: URL?

    var didCallAuthorizeHook: (() -> Void)?

    private(set) var authorizeCallCount = 0

    var mockResponse: OpenIdServiceResult = .code(MockOpenIdService.mockSuccess) {
        didSet {
            responseQueue.mockResponses = [mockResponse]
        }
    }

    var responseQueue = MockResponseQueue<OpenIdServiceResult>([
        .code(MockOpenIdService.mockSuccess),
    ])

    func clear() {
        lastParameters = nil
        lastViewController = nil
        responseQueue.clear()
        authorizeCallCount = 0

        lastURL = nil
        holdCompletionUntilURL = false
        didCallAuthorizeHook = nil
    }

    func authorize(
        fromViewController viewController: UIViewController,
        carrierConfig: CarrierConfig,
        authorizationParameters: OpenIdAuthorizationRequest.Parameters,
        completion: @escaping OpenIdServiceCompletion) {

        authorizeCallCount += 1
        self.lastViewController = viewController
        self.lastParameters = authorizationParameters
        self.lastCompletion = completion

        if !holdCompletionUntilURL {
            DispatchQueue.main.async {
                self.complete()
            }
        }
        didCallAuthorizeHook?()
    }

    var authorizationInProgress: Bool = false

    func cancelCurrentAuthorizationSession() { }

    func resolve(url: URL) -> Bool {
        lastURL = url
        if lastCompletion != nil {
            complete()
            return true
        } else {
            return false
        }
    }

    func concludeAuthorizationFlow(result: AuthorizationResult) { }

    private func complete() {
        lastCompletion?(responseQueue.getResponse())
    }
}