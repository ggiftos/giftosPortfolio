//
//  PostData.swift
//  H4X0R News-SwiftUI
//
//  Created by Grant Giftos on 9/30/22.
//

import Foundation

struct Results: Decodable {
  let hits: [Post]
}

struct Post: Decodable, Identifiable {
  var id: String {
    return objectID
  }
  let objectID: String
  let title: String
  let points: Int
  let url: String?
}
