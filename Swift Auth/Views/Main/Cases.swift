//
//  Cases.swift
//  LawyerIOS
//
//  Created by Khanh Nguyen on 5/27/26.
//

import SwiftUI

struct Cases: View {
	 struct Case {
			var id: UUID
			var title: String
			var status: String
	 }
	 @State private var authUI = AuthUI.shared

    var body: some View {
			 NavigationStack {

					List {
						 ForEach(cases, id: \.id) { item in
								HStack(alignment: .top) {
									 VStack(alignment: .leading) {
											Text(item.id.uuidString.prefix(10))
												 .font(.caption)
												 .foregroundStyle(.secondary)
											Text(item.title)
												 .font(.subheadline)
									 }
									 Spacer()
									 Text(item.status)
											.font(.caption)
											.foregroundStyle(.secondary)
								}
						 }
					}
					.toolbar {
						 ToolbarItem(placement: .topBarTrailing) {
								Text(authUI.userName)
						 }
						 .sharedBackgroundVisibility(.hidden)
					}
			 }
    }


	 let cases: [Case] = [
			Case(id: UUID(), title: "State v. Johnson", status: "Open"),
			Case(id: UUID(), title: "State v. Ramirez", status: "In Review"),
			Case(id: UUID(), title: "State v. Lee", status: "Closed"),
			Case(id: UUID(), title: "State v. Patel", status: "Open"),
			Case(id: UUID(), title: "State v. Brown", status: "Pending"),
			Case(id: UUID(), title: "State v. Davis", status: "Closed"),
	 ]
}

#Preview {
    Cases()
}
