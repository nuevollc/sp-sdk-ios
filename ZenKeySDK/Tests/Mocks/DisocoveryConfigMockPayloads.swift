//
//  DiscoveryConfigMocks.swift
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

enum DiscoveryConfigMockPayloads {
    static let success: [String: Any] = [
        "acr_values_supported": [
            "loa2",
            "loa3",
        ],
        "authorization_endpoint": "https://xcid.t-mobile.com/verify/authorize",
        "display_values_supported": [
            "none",
            "page",
        ],
        "grant_types_supported": [
            "authorization_code",
        ],
        "id_token_signing_alg_values_supported": [
            "RS256",
        ],
        "issuer": "https://brass.account.t-mobile.com",
        "jwks_uri": "https://brass.account.t-mobile.com/oauth2/v1/certs",
        "response_types_supported": [
            "code",
            "code id_token",
        ],
        "scopes_supported": [
            "openid",
            "profile",
            "email",
            "address",
        ],
        "service_documentation": "mailto:iamengineering@t-mobile.com",
        "subject_types_supported": [
            "public",
        ],
        "token_endpoint": "https://brass.account.t-mobile.com/tms/v3/usertoken",
        "token_endpoint_auth_methods_supported": [
            "client_secret_post",
            "client_secret_basic",
        ],
        "userinfo_endpoint": "https://iam.msg.t-mobile.com/oidc/v1/userinfo",
        "mccmnc": Int(MockSIMs.tmobile.mccmnc)!,
    ]

    static let carrierNotFound: [String: Any] = [
        "error": "provider_not_found",
        "redirect_uri": "https://app.xcijv.com/ui/discovery-ui",
    ]
}
