//
//  ImageGridView.swift
//  CodingTest
//
//  Created by David on 2022-11-28.
//

import SwiftUI

struct SingleImageView: View {
    var model: SinglePhoto
    var body: some View {
        ImageResultView(url: model.url ?? "", key: model.id)
    }
}
