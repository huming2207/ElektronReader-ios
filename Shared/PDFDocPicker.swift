import Foundation
import SwiftUI
import UIKit

struct PDFDocPicker: UIViewControllerRepresentable {
    
    @Binding var outputData: Data?
    
    func makeCoordinator() -> PDFDocPicker.Coordinator {
        return PDFDocPicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PDFDocPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PDFDocPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<PDFDocPicker>) {
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        
        var parent: PDFDocPicker
        
        init(parent1: PDFDocPicker){
            parent = parent1
        }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            let path = urls[0]
            guard path.startAccessingSecurityScopedResource(),
                let data = try? Data(contentsOf: path) else { return }
            path.stopAccessingSecurityScopedResource()
            
            parent.outputData = data
            print(urls[0].absoluteString)
        }
    }
}
