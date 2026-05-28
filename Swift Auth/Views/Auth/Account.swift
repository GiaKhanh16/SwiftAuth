	 //
	 //  CreateAccount.swift
	 //  LawyerIOS
	 //
	 //  Created by Khanh Nguyen on 5/20/26.
	 //

import SwiftUI

struct CreateAccount: View {
	 @State private var clientAuth = ClientAuth()
	 @State private var authUI = AuthUI.shared
	 var body: some View {
			VStack {
				 HStack(spacing: 0) {
						Button { authUI.isClient = true } label: {
							 Text("Client")
									.font(.title3)
									.foregroundStyle(authUI.isClient ? .white : .blue)
									.hSpacing(alignment: .center)
									.padding(.vertical)
									.background(authUI.isClient ? .blue : .white)

						}
						Button { authUI.isClient = false} label: {
							 Text("Attorney")
									.font(.title3)
									.foregroundStyle(authUI.isClient ? .blue : .white)
									.padding(.vertical)
									.hSpacing(alignment: .center)
									.background(authUI.isClient ? .white : .blue)

						}
				 }.padding(.vertical)
				 loginInput(caption: "name", isPassword: false,
										color: !clientAuth.name.isEmpty ? .green
						.opacity(0.6) : .gray
						.opacity(0.15),
										text: $clientAuth.name)
				 loginInput(caption: "email", isPassword: false,
										color: clientAuth.validEmail ? .green
						.opacity(0.6) : .gray
						.opacity(0.15),
										text: $clientAuth.email)
				 loginInput(caption: "password", isPassword: true,
										color:  clientAuth.passwordValid ? .green
						.opacity(0.6) : .gray
						.opacity(0.15),
										text: $clientAuth.password)
				 loginInput(
						caption: "confirm password",
						isPassword: true,
						color:  clientAuth.passwordConfirmed ? .green
							 .opacity(0.6) : .gray
							 .opacity(0.15),
						text: $clientAuth.confirmPassword
				 )
				 .padding(.bottom)

				 if !clientAuth.passwordValid {
							 VStack(alignment: .leading, spacing: 8) {

									Text("• At least 1 uppercase letter")

									Text("• At least 1 lowercase letter")

									Text("• At least 1 number")

									Text("• At least 1 special character")

									Text("• Minimum 8 characters")
							 }
							 .hSpacing(alignment: .leading)
							 .font(.subheadline)
							 .padding(.bottom)
				 }
				 



				 Button {
						Task {
							 await clientAuth.accountCreation()
						}
				 } label: {
						HStack {
							 Text("Create Account")
									.foregroundStyle(.white)
									.frame(maxWidth: .infinity)
									.padding()
									.background(.selection, in: .rect(cornerRadius: 10))
						}
				 }

				 Text(clientAuth.successOrFail)
						.foregroundStyle(.primary)
						.font(.headline)
						.padding()

				if authUI.isSpinner {
						Image(systemName: "rays")
							 .foregroundStyle(.blue)
							 .font(.title)
							 .symbolEffect(.rotate)
				 }

				 Spacer()
			}
			.animation(
				 .easeInOut(duration: 0.25),
				 value: clientAuth.passwordValid
			)
			.padding()
			.navigationTitle("Create Account")

	 }
}

struct loginInput: View {
	 var caption: String
	 var isPassword: Bool
	 var color: Color
	 @Binding var text: String


	 var body: some View {
			VStack(spacing: 10) {
				 Text(caption)
						.font(.headline)
						.fontWeight(.light)
						.hSpacing(alignment: .leading)
				 if isPassword {
						SecureField("", text: $text)
							 .autocapitalization(.none)
							 .padding()
							 .hSpacing(alignment: .leading)
							 .background(color, in: .rect(cornerRadius: 5))

				 } else {
						TextField("", text: $text)
							 .autocapitalization(.none)
							 .keyboardType(.emailAddress)
							 .padding()
							 .hSpacing(alignment: .leading)
							 .background(color, in: .rect(cornerRadius: 5))
				 }
			}
	 }
}

#Preview {
	 NavigationStack {
			CreateAccount()
	 }
}
