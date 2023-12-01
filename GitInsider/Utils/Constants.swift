//
//  Constants.swift
//  GitInsider
//
//  Created by Alphan Ogün on 14.11.2023.
//

import Foundation

let gitHubClientId = "Iv1.cde7109a50455daa"
let gitHubClientSecret = "e777cbf29c52d3b301c2ab86e4ef259f01ef9757"
let gitHubRedirectUri = "gitinsider://github/callback"

let gitHubAuthLink = "https://github.com/login/oauth/authorize?client_id=\(gitHubClientId)"
let gitHubSignupLink = "https://github.com/signup"

let authUsername = "Authenticated username"
let accessTokenInKeychain = "Access Token"
let accessTokenExpirationKeyInDefaults = "AccessTokenExpiration"
