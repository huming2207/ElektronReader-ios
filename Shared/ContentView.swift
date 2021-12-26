//
//  ContentView.swift
//  Shared
//
//  Created by Jackson Hu on 26/12/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State
    private var pdfDoc: Data?
    
    @State
    private var openFilePicker: Bool = false
    

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { openFilePicker = true }) {
                        Label("Open PDF file", systemImage: "plus")
                    }
                }
            }
            
            VStack(alignment: .leading) {
                if ((pdfDoc) != nil) {
                    let _ = print(pdfDoc!)
                    PDFDocView(data: pdfDoc!, autoScales: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("Go open a doc")
                        
                }
                Spacer()
            }.frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            ).sheet(
                isPresented: $openFilePicker,
                onDismiss: loadPDF,
                content: { PDFDocPicker(outputData: $pdfDoc) }
            ).background(Color.white).frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationBarHidden(true)
        }
    }

    private func loadPDF() {
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPad mini (6th generation)").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.landscapeLeft)
    }
}
