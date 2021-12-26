import Foundation
import PDFKit
import SwiftUI

struct PDFDocView : UIViewRepresentable {

    private var data: Data?
    private var url: URL?
    private let autoScales : Bool
    
    init(data: Data, autoScales: Bool = true) {
        self.data = data
        self.autoScales = autoScales
    }
    
    init(url: URL, autoScales: Bool = true) {
        self.url = url
        self.autoScales = autoScales
    }

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()

        pdfView.displayMode = .singlePageContinuous
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.setValue(true, forKey: "forcesTopAlignment")
        pdfView.autoScales =  self.autoScales
       
        if let data = self.data {
            pdfView.document = PDFDocument(data: data)
        } else if let url = self.url {
            print("Opening URL")
            pdfView.document = PDFDocument(url: url)
        }
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Empty
    }
}
