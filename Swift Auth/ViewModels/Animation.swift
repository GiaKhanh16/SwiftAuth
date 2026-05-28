//
//  Animation.swift
//  LawyerIOS
//
//  Created by Khanh Nguyen on 5/25/26.
//

import SwiftUI

class CustomAnimation {
	 private var animatedVector: [Bool] = Array(repeating: false, count: 3)

	 func delayAnimation(_ delay: Double, action: @escaping () -> ()) async {
			try? await Task.sleep(for: .seconds(2))
			withAnimation(.smooth) {
				 
			}
	 }
}
