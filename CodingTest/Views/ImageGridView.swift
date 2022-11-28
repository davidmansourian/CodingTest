//
//  ImageGridView.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import SwiftUI

struct ImageGridView: View {
    private let columns = [GridItem(.adaptive(minimum: 100), spacing: 0)]
    var model: SinglePhoto
    var body: some View {
            ImageResultView(url: model.url ?? "")
    }
}
