//
//  ImagePicker.swift
//  ImageInCoreData
//
//  Created by App Designer2 on 10.08.20.
//

import SwiftUI


struct ImagePicker : UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(img1: self)
    }
    
    @Binding public var show : Bool
    @Binding public var image : Data
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator // This delegate allows the imgs to appear on the wherever we want to, after choose any image
        return picker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) {
        //This will keeping empty, we dont have to implement anything on here
        //because we dont need it.
    }
    class Coordinator: NSObject,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        //This allows us to navigate into the ImagePicker to choose any image!!!
        var img0 : ImagePicker
        init(img1: ImagePicker) {
            img0 = img1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.img0.show.toggle() // This allows us to cancel with no choose any image
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let images = info[.originalImage] as! UIImage
            
            let dataImg = images.jpegData(compressionQuality: 0.50)//This convert the image in Data
            
            self.img0.image = dataImg!
            self.img0.show.toggle() //This implementation dismiss the ImagePickerView after choose any image
        }
    }
}
