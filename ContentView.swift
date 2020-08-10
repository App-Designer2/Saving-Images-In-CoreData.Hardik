//
//  ContentView.swift
//  ImageInCoreData
//
//  Created by App Designer2 on 10.08.20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Saving.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Saving.imageD, ascending: true),
        NSSortDescriptor(keyPath: \Saving.name, ascending: true),
        NSSortDescriptor(keyPath: \Saving.detail, ascending: true),
        NSSortDescriptor(keyPath: \Saving.rating, ascending: false),
        NSSortDescriptor(keyPath: \Saving.loved, ascending: false)
    ]) var saved : FetchedResults<Saving>
    
    @State public var image : Data = .init(count: 0)
    @State public var show : Bool = false
    
    
    static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        return formatter
    }()
    
    var date = Date()
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(saved, id: \.self) { save in
                    VStack(alignment: .leading) {
                        
                        Image(uiImage: UIImage(data: save.imageD ?? self.image)!)
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                        
                        HStack {
                            ForEach(0..<5, id: \.self) { star in
                                HStack {
                                Button(action: {
                                    save.rating = star
                                    
                                    try! self.moc.save()
                                }) {
                                    Image(systemName: save.rating >= star ? "star.fill": "star")
                                        .foregroundColor(save.rating >= star ? .yellow : .gray)
                                }//button
                                    
                                }//Hstack rating child
                                
                            }//ForEach rating
                            
                            Spacer()
                            
                            Button(action: {
                                save.loved.toggle()
                                
                                try! self.moc.save()
                            }) {
                                Image(systemName: save.loved ? "heart.fill": "heart")
                                    .foregroundColor(save.loved ? .red : .gray)
                            }//button loved
                            
                        }//.padding()//HStack rating father
                        Text("\(save.date ?? self.date, formatter: Self.dateFormatter)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("\(save.name!)")
                            .font(.headline)
                        
                        
                        Text("\(save.detail!)")
                            .font(.callout)
                    }
                }.padding()//Main ForEach
            }.navigationTitle("SavingInCoreData")
            .navigationBarItems(leading: Button(action: {
                self.show.toggle()
            }) {
                Image(systemName: "plus")
            })
        }.sheet(isPresented: self.$show) {
            CreateNew().environment(\.managedObjectContext, self.moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
