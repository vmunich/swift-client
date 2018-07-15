// 
// This file is part of Ark Swift Client.
//
// (c) Ark Ecosystem <info@ark.io>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Alamofire
import Foundation


/// ApiHandler aliases
typealias ApiGetHandler = (String, [String: Any]?, @escaping (Dictionary<String, Any>?) -> Void) -> Void
typealias ApiGetHandlerTest<T: Decodable> = (String, [String: Any]?, String, @escaping (T?, ArkError?, String) -> Void) -> Void
typealias ApiPostHandler = (String, [String: Any]?, [String: Any]?, @escaping (Dictionary<String, Any>?) -> Void) -> Void

/// Handles api get requests
///
/// - Parameters:
///   - url: the url to which the request is made
///   - parameters: a dictionary of additional parameters that are send along with the request
///   - completionHandler: function to handle the response
func handleApiGet(_ url: String, _ parameters: [String: Any]?, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
    Alamofire.request(url, parameters: parameters).responseJSON { response in
        if let json = response.result.value {
            completionHandler(json as? Dictionary<String, Any>)
        } else {
            completionHandler(nil)
        }
    }
}

func handleApiGetTest<T: Decodable>(_ url: String, _ parameters: [String: Any]?, _ property: String, completionHandler: @escaping (T?, ArkError?, String) -> Void) {
    Alamofire.request(url, parameters: parameters)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            let requestUrl = response.request?.url?.absoluteString ?? ""
            switch response.result {
            case .success:
                if let json = response.result.value as? Dictionary<String, Any> {
                    if json["success"] as! Bool {
                        // For succesful response, try constructing a model from it
                        do {
                            let decoder = JSONDecoder()
                            let responseData = try JSONSerialization.data(withJSONObject: json[property]!)
                            let decodedResponse = try decoder.decode(T.self, from: responseData)
                            completionHandler(decodedResponse, nil, requestUrl)
                        } catch let err {
                            completionHandler(nil, ArkError.invalidJSON(err.localizedDescription), requestUrl)
                        }
                    } else {
                        // For success = false, return error description the API provides
                        completionHandler(nil, ArkError.unsuccessfulResponse(json["error"]! as! String), requestUrl)
                    }
                } else {
                    // Unexpected; response did not contain a result value
                    completionHandler(nil, ArkError.unexpectedResponse("Request did not contain a result value"), requestUrl)
                }
            case .failure(let error):
                // The response was not in the 2xx range (e.g. a server error)
                completionHandler(nil, ArkError.invalidResponse(error.localizedDescription), requestUrl)
            }
    }
}

/// Handles api post requests
func handleApiPost(_ url: String, _ parameters: [String: Any]?, _ body: [String: Any]?, completionHandler: @escaping (Dictionary<String, Any>?) -> Void) {
    var urlComponents = URLComponents(string: url)!
    
    // Create our own url including the parameters
    if let params = parameters {
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: String(describing: value)))
        }
        urlComponents.queryItems = queryItems
    }
    Alamofire.request(urlComponents, method: .post, parameters: body)
}
