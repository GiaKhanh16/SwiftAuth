//
//  ViewExtensions.swift
//  LawyerIOS
//
//  Created by Khanh Nguyen on 5/20/26.
//

import SwiftUI

extension View {
	 @ViewBuilder
	 func hSpacing(alignment: Alignment) -> some View {
			self
				 .frame(maxWidth: .infinity, alignment: alignment)
	 }
}
