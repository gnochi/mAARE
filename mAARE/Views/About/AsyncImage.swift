//
//  AsyncImage.swift
//  mAARE
//
//  Created by Dimitri Suter on 24.07.20.
//  Copyright © 2020 Dimitri Suter. All rights reserved.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
	@ObservedObject private var loader: ImageLoader
	private let placeholder: Placeholder?
	
	init(url: URL, placeholder: Placeholder? = nil) {
		loader = ImageLoader(url: url)
		self.placeholder = placeholder
	}
	
	var body: some View {
		image
			.onAppear(perform: loader.load)
			.onDisappear(perform: loader.cancel)
	}
	
	private var image: some View {
		Group {
			if loader.image != nil {
				Image(uiImage: loader.image!)
					.resizable()
			} else {
				placeholder
			}
		}
	}
}

