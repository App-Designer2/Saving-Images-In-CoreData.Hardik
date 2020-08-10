//
//  CreateNew.swift
//  ImageInCoreData
//
//  Created by App Designer2 on 10.08.20.
//

import SwiftUI

struct CreateNew: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var dismiss
    
    @State public var name : String = ""
    @State public var detail : String = ""
    @State public var image : Data = .init(count: 0)
    @State public var show : Bool = false
    var body: some View {
        NavigationView {
            VStack {
                if self.image.count != 0 {
                    Button(action: {
                        self.show.toggle()
                    }) {
                    Image(uiImage: UIImage(data: self.image)!)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(6)
                        .shadow(radius: 4)
                    }
                } else {
                    Button(action: {
                        self.show.toggle()
                    }) {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.secondary)
                        .cornerRadius(6)
                        .shadow(radius: 4)
                    }
                }//Else imagePicker
                
                TextField("Name...", text: self.$name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Detail...", text: self.$detail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    //This implementation will add the data in the persistentContainer/CoreData/Store/ to display on the Main view = ( ContentView )
                    let add = Saving(context: self.moc)
                    add.imageD = self.image
                    add.name = self.name
                    add.detail = self.detail
                    
                    try! self.moc.save() // permant saved
                    
                    self.dismiss.wrappedValue.dismiss() // This will dismiss this CreaterNew View to send us to the Main View = ( ContentView ) to see that the data was saved and appear on it!!
                }) {
                    Text("Create new")
                        .bold()
                        .foregroundColor(self.image.count > 0 && self.detail.count > 5 && self.name.count > 5 ? .white : .black)
                        .background(self.image.count > 0 && self.detail.count > 5 && self.name.count > 5 ? Color.blue : Color.gray)
                        .padding()
                        .frame(width: 130, height: 40)
                        .cornerRadius(10)
                        .shadow(radius: 8)
                        
                }.disabled(self.image.count > 0 && self.detail.count > 5 && self.name.count > 5 ? false : true)
                Spacer()
                
            }.navigationTitle("Create new")
            .navigationBarItems(trailing: Button(action: {
                    self.dismiss.wrappedValue.dismiss()}) {
                Text("Cancel")
            })
        }.sheet(isPresented: self.$show) {
            ImagePicker(show: self.$show, image: self.$image)
        }
    }
}

struct CreateNew_Previews: PreviewProvider {
    static var previews: some View {
        CreateNew()
    }
}
