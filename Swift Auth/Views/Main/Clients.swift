//
//  Clients.swift
//  LawyerIOS
//
//  Created by Khanh Nguyen on 5/27/26.
//

import SwiftUI

struct Clients: View {
	 struct Messages {
			var id: UUID
			var lastMessage: String
			var clientName: String
			var lastMessageTime: Date
			var clientIntiial: String {
				 var result: String = ""
				 let splitted = clientName.split(separator: " ")
				 for i in splitted {
						result.append(String(i.first!))
				 }
				 return result
			}
	 }
    var body: some View {
			 NavigationStack {
					List {
						 ForEach(sampleMessages, id: \.id) { item in
								HStack(spacing: 22) {
									 Text(item.clientIntiial)
											.foregroundStyle(.white)
											.padding(15)
											.background(.gray.opacity(0.9), in: .rect(cornerRadius: 20))
									 VStack(alignment: .leading, spacing: 5) {
											Text(item.clientName)
												 .font(.subheadline.bold())
											Text(item.lastMessage)
												 .font(.footnote)
												 .foregroundStyle(.secondary)
												 .frame(maxWidth: .infinity, alignment: .leading)
									 }
									 Spacer()
									 Text(item.lastMessageTime, style: .time)
											.font(.caption2)

								}
						 }
					}
			 }
    }


	 let sampleMessages: [Messages] = [
			Messages(
				 id: UUID(),
				 lastMessage: "See you in court tomorrow.",
				 clientName: "John Doe",
				 lastMessageTime: Date()
			),
			Messages(
				 id: UUID(),
				 lastMessage: "Need an update on my case.",
				 clientName: "Maria Garcia",
				 lastMessageTime: Date().addingTimeInterval(-3600)
			),
			Messages(
				 id: UUID(),
				 lastMessage: "Thanks for the help.",
				 clientName: "Alex Kim",
				 lastMessageTime: Date().addingTimeInterval(-86400)
			),
			Messages(
				 id: UUID(),
				 lastMessage: "Can we reschedule?",
				 clientName: "Samantha Lee",
				 lastMessageTime: Date().addingTimeInterval(-7200)
			),
			Messages(
				 id: UUID(),
				 lastMessage: "Got it, thank you.",
				 clientName: "David Johnson",
				 lastMessageTime: Date().addingTimeInterval(-18000)
			)
	 ]
}

#Preview {
    Clients()
}
