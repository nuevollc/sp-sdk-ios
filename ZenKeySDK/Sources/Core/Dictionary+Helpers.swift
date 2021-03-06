//
//  Dictionary+Helpers.swift
//  ZenKeySDK
//
//  Created by Adam Tierney on 7/25/19.
//  Copyright © 2019-2020 ZenKey, LLC.
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

extension Dictionary where Value: Any {
    subscript<T>(_ key: Key, or `default`: @autoclosure () -> T) -> T {
        if let value = self[key] as? T {
            return value
        }
        return `default`()
    }
}
