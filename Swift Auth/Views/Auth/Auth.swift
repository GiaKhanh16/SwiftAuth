//
//  LogIn.swift
//  LawyerIOS
//
//  Created by Khanh Nguyen on 5/19/26.
//

import SwiftUI

struct Login: View {
	 @State private var authClient = ClientAuth()
	 @State private var authUI = AuthUI.shared
	 var body: some View {
			NavigationStack {
				 VStack {
						Text("Welcome To LawyerOS")
							 .font(.largeTitle)
							 .fontWeight(.medium)
							 .padding(.vertical)

						HStack {
							 Button {
									authUI.isClient = true
							 } label: {
									Text("For Clients")
										 .foregroundStyle(authUI.isClient ? .blue : .secondary)
										 .font(.title2)
										 .padding(.bottom)
										 .hSpacing(alignment: .center)
										 .overlay(alignment: .bottom) {
												Rectangle()
													 .frame(height: 2)
													 .foregroundStyle(authUI.isClient ? .blue : .clear)
										 }
							 }

							 Button {
									authUI.isClient = false
							 } label: {
									Text("For Attorneys")
										 .foregroundStyle(!authUI.isClient ? .blue : .secondary)
										 .font(.title2)
										 .hSpacing(alignment: .center)
										 .padding(.bottom)
										 .overlay(alignment: .bottom) {
												Rectangle()
													 .frame(height: 2)
													 .foregroundStyle(!authUI.isClient ? .blue : .clear)
										 }
							 }
						}
						.frame(maxWidth: .infinity)

						VStack(spacing: 20) {
							 loginInput(caption: "username", isPassword: false, color: .gray
									.opacity(0.15), text: $authClient.email)
							 loginInput(
									caption: "password",
									isPassword: true,
									color: .gray.opacity(0.15),
									text: $authClient
										 .password)
						}
						.padding(.vertical)

						Button {
							 Task {
									await authClient.accountAuthorization()
							 }
						} label: {
							 HStack {
									Text("Sign In")
										 .foregroundStyle(.white)
										 .frame(maxWidth: .infinity)
										 .padding()
										 .background(.selection, in: .rect(cornerRadius: 10))
								
							 }
						}
						Text("Forgot Password ?")
							 .foregroundStyle(.secondary)
							 .font(.footnote)
							 .hSpacing(alignment: .trailing)
							 .padding(.vertical, 10)

						Text(authClient.successOrFail)
							 .foregroundStyle(.secondary)
							 .font(.footnote)
							 .hSpacing(alignment: .center)
							 .padding(.vertical, 10)

						Spacer()

						Button {
							 authUI.showCreateAccount = true
						} label: {
							 Text("Create an Account")
						}
				 }
				 .padding(.horizontal)
				 .navigationDestination(isPresented: $authUI.showCreateAccount) {
						CreateAccount()
				 }
				 .navigationTransition(.automatic)
			}

	 }
}

#Preview {
	 Main()
}
