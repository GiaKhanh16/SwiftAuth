//
//  ContentView.swift
//  LawyerIOS
//
//  Created by Khanh Nguyen on 5/6/26.
//

import SwiftUI


struct Main: View {
	 @State private var authUI = AuthUI.shared
	 var body: some View {
			Group {
				 if authUI.authorized {
						Tabs()
				 } else {
						Login()
				 }
			}
		
	 }
}


#Preview {
    Main()
}
