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


struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(model: SinglePhoto(id: "1", owner: "1", secret: "1", server: "2", farm: 1, title: "1", ispublic: 1, isfriend: 1, isfamily: 1))
    }
}
