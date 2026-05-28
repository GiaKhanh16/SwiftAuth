//
//  AuthUI.swift
//  LawyerIOS
//
//  Created by Khanh Nguyen on 5/26/26.
//


import SwiftUI
@Observable

class AuthUI {
	 static let shared = AuthUI()
	 public var authorized: Bool = false
	 public var isSpinner: Bool = false
	 public var isClient: Bool = true
	 public var showCreateAccount: Bool = false

	 public var userName: String = ""
}
