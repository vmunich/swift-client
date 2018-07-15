// 
// This file is part of Ark Swift Client.
//
// (c) Ark Ecosystem <info@ark.io>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Foundation

struct AccountsOne: Codable {
    let address, unconfirmedBalance, balance, publicKey: String
    let unconfirmedSignature, secondSignature: Int
    let secondPublicKey: String
    let multisignatures, uMultisignatures: [String]?

    enum CodingKeys: String, CodingKey {
        case address, unconfirmedBalance, balance, publicKey, unconfirmedSignature, secondSignature, secondPublicKey, multisignatures
        case uMultisignatures = "u_multisignatures"
    }
}

