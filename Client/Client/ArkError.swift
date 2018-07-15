//
// This file is part of Ark Swift Client.
//
// (c) Ark Ecosystem <info@ark.io>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Foundation

enum ArkError: Error {
    case invalidResponse(String) // Used for responses that did not pass response validation
    case unsuccessfulResponse(String) // Used for responses that returned success: false
    case invalidJSON(String) // Used for responses that could not be parsed to expected Model
    case unexpectedResponse(String) // Used for responses without a result.value property
}
