//
// This file is part of Ark Swift Client.
//
// (c) Ark Ecosystem <info@ark.io>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Foundation

extension Two {
    class Delegates {
        
        private let client: ArkClient
        private let apiGetHandler: ApiGetHandler
        private var endpoint: String {
            get {
                return "\(client.host)/delegates"
            }
        }
        
        public init(client: ArkClient, _ apiGetHandler: @escaping ApiGetHandler = handleApiGet) {
            self.client = client
            self.apiGetHandler = apiGetHandler
        }
        
        /// Retrieves the given delegate
        /// id can be one of: Username, Address or Public Key
        public func get(byName id: String, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
            apiGetHandler("\(endpoint)/\(id)", [:], completionHandler)
        }
        
        public func get(byAddress id: String, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
            apiGetHandler("\(endpoint)/\(id)", [:], completionHandler)
        }
        
        public func get(byKey id: String, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
            apiGetHandler("\(endpoint)/\(id)", [:], completionHandler)
        }
        
        /// Retrieves all delegates
        public func all(limit: Int = 20, page: Int = 1, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
            apiGetHandler(endpoint, ["limit": limit, "page": page], completionHandler)
        }
        
        /// Retrieves all forged blocks of a given delegate
        public func blocks(byName id: String, limit: Int = 20, page : Int = 1, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
            apiGetHandler("\(endpoint)/\(id)/blocks", ["limit": limit, "page": page], completionHandler)
        }
        
        public func blocks(byAddress id: String, limit: Int = 20, page : Int = 1, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
            apiGetHandler("\(endpoint)/\(id)/blocks", ["limit": limit, "page": page], completionHandler)
        }
        
        public func blocks(byKey id: String, limit: Int = 20, page : Int = 1, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
            apiGetHandler("\(endpoint)/\(id)/blocks", ["limit": limit, "page": page], completionHandler)
        }
        
        /// Retrieves all voters of a given delegate
        public func voters(byName id: String, limit: Int = 20, page : Int = 1, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
            apiGetHandler("\(endpoint)/\(id)/voters", ["limit": limit, "page": page], completionHandler)
        }
        
        public func voters(byAddress id: String, limit: Int = 20, page : Int = 1, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
            apiGetHandler("\(endpoint)/\(id)/voters", ["limit": limit, "page": page], completionHandler)
        }
        
        public func voters(byKey id: String, limit: Int = 20, page : Int = 1, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
            apiGetHandler("\(endpoint)/\(id)/voters", ["limit": limit, "page": page], completionHandler)
        }
    }
}