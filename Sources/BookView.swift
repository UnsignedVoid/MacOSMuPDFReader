//
//  File.swift
//
//
//  Created by Kiryl Matsaberydze on 28/01/2024.
//

import Foundation
import MuPDF
import SwiftUI
import System
import os

let main_logger = Logger(subsystem: "Main", category: "Main")

class MuPDFReader {
  let pdf: MuPDF
  let logger: Logger
  let id = UUID()

  init() throws {
    self.pdf = try MuPDF()
    self.logger = Logger(subsystem: "MuPDFEngine", category: "Engine")
  }

  convenience init(path: FilePath, scale_x: Float, scale_y: Float, rotate_by: Float) throws {
    try self.init()
    try self.pdf.openDoc(path: path)
    self.pdf.setPageTransform(scale_x: scale_x, scale_y: scale_y, rotate_by: rotate_by)
  }

  public func load(path: FilePath) throws {
    try self.pdf.openDoc(path: path)
  }

  public func getPage(pageNum: Int) throws -> CGImage {
    return try self.pdf.getPagePixmap(page_number: Int32(pageNum))
  }
}

struct BookView: View {
  let pdf_reader = try! MuPDFReader(
    path: FilePath(ProcessInfo.processInfo.environment["BOOKPATH"]!),
    scale_x: 1.0, scale_y: 1.0, rotate_by: 0)
  var body: some View {

    ScrollView {
      LazyVStack(alignment: .leading) {
        ForEach(1...Int(pdf_reader.pdf.pageCount), id: \.self) {
          Image(decorative: try! pdf_reader.getPage(pageNum: $0), scale: 1)
        }
      }
    }

  }
}

#Preview {
  BookView()
}
