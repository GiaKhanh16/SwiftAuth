	 //
	 //  ClientAuth.swift
	 //  LawyerIOS
	 //
	 //  Created by Khanh Nguyen on 5/24/26.
	 //

import SwiftUI

@Observable class ClientAuth {

	 private var authUI = AuthUI.shared
	 public var email: String = ""
	 public var name: String = ""
	 public var password: String = ""
	 public var confirmPassword: String = ""
	 public var errorMessage: String = ""
	 public var success: Bool = false

	 public var successOrFail: String {
			if success {
				 return "Create Account Successfully"
			} else {
				 return errorMessage
			}
	 }

	 public var validEmail: Bool {
			let emailRegex =
			#"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

			return email.range(
				 of: emailRegex,
				 options: .regularExpression
			) != nil
	 }

	 public var passwordValid: Bool {
			let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
			let hasLowercase = password.range(of: "[a-z]", options: .regularExpression) != nil
			let hasNumber = password.range(of: "[0-9]", options: .regularExpression) != nil
			let hasSpecial = password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil
			let hasMinLength = password.count >= 8

				 return hasUppercase &&
				 hasLowercase &&
				 hasNumber &&
				 hasSpecial &&
				 hasMinLength
	 }

	 public var passwordConfirmed: Bool {
			guard !self.password.isEmpty, !self.confirmPassword.isEmpty else { return false }
			return self.password == self.confirmPassword
	 }


	 public func accountCreation() async  {
			guard passwordValid, validEmail, !name.isEmpty else {
				 errorMessage = "Missing information"
				 return
			}
			guard passwordConfirmed else {
				 errorMessage = "Password mismatched"
				 return
			}
			

			authUI.isSpinner = true


			let body = [
				 "email": email,
				 "password": password,
				 "name": name
			]
			let data = try? JSONSerialization.data(withJSONObject: body)
			let url = URL(string: "http://localhost:3000/\(authUI.isClient ? "client" : "attorney")/auth")
			var request = URLRequest(url: url!)
			request.httpMethod = "POST"
			request.addValue("application/json", forHTTPHeaderField: "Content-Type")
			request.httpBody = data
			do {
				 let (data, response) = try await URLSession.shared.data(for: request)
				 print(request)
				 if let httpResponse = response as? HTTPURLResponse {
						if httpResponse.statusCode == 201 {
							 self.success = true
							 authUI.userName = name

							 withAnimation(.smooth(duration: 2)) {
									authUI.isSpinner = false
									authUI.authorized = true
							 }
						} else {
							 let data =  try JSONDecoder().decode(ErrorResponse.self, from: data)

							 withAnimation(.smooth(duration: 2)) {
									authUI.isSpinner = false
							 }

							 self.errorMessage = data.error
						}
				 }
				 print(String(data: data, encoding: .utf8)!)
			} catch {
				 print(error.localizedDescription)
			}
	 }

	 public func accountAuthorization() async  {
			guard !email.isEmpty, !password.isEmpty else {
				 errorMessage = "Missing information"
				 return
			}

			authUI.isSpinner = true

			let body = [
				 "email": email,
				 "password": password,
			]

			let data = try? JSONSerialization.data(withJSONObject: body)
			let url = URL(string: "http://localhost:3000/client/auth-in")
			var request = URLRequest(url: url!)
			request.httpMethod = "POST"
			request.addValue("application/json", forHTTPHeaderField: "Content-Type")
			request.httpBody = data
			do {
				 let (data, response) = try await URLSession.shared.data(for: request)

				 if let httpResponse = response as? HTTPURLResponse {
						if httpResponse.statusCode == 201 {
							 let data = try JSONDecoder().decode(
									AuthorizedResponse.self,
									from: data
							 )
							 self.success = true
							 authUI.userName = data.username

							 withAnimation(.smooth(duration: 2)) {
									authUI.isSpinner = false
									authUI.authorized = true
							 }
						} else {
							 let data = try JSONDecoder().decode(ErrorResponse.self, from: data)

							 withAnimation(.smooth(duration: 2)) {
									authUI.isSpinner = false
							 }

							 self.errorMessage = data.error
						}
				 }
				 print(String(data: data, encoding: .utf8)!)
			} catch {
				 print(error.localizedDescription)
			}
	 }
}

extension ClientAuth {
	 struct AuthorizedResponse: Decodable {
			var username: String
			var token: String
	 }
	 struct ErrorResponse: Decodable {
			var error: String
	 }
}
