//
//  HomeView.swift
//  LawyerIOS
//
//  Created by Khanh Nguyen on 5/23/26.
//

import SwiftUI

struct Tabs: View {
    var body: some View {
			 TabView {

					Tab("", systemImage: "folder") {
						 Cases()
					}
					Tab("", systemImage: "calendar.and.person") {
						 Clients()
					}


					Tab(role: .search) {
					}
			 }
    }
}

#Preview {
	 Tabs()
}
