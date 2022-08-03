//
//  Picker.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 30.06.2022.
//

import PhotosUI
import SwiftUI


class WrappedPhotoPicker: UIViewController {
    var picker: PHPickerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let picker = picker {
            present(picker, animated: false)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var images: [UIImage]
    @Binding var newImages: [UIImage]
    @Binding var totalImage: Int
    var isUpdate: Bool = false
    let wrappedPicker = WrappedPhotoPicker()
    
    func makeUIViewController(context: Context) -> some WrappedPhotoPicker {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = totalImage
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        wrappedPicker.picker = picker
        return wrappedPicker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
  
    final class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            parent.wrappedPicker.dismiss(animated: false)
            for result in results {
                let itemProvider = result.itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self){
                    itemProvider.loadObject(ofClass: UIImage.self) {[weak self] image, error in
                        if let decodedImage = image as? UIImage,  let safeSelf = self{
                            DispatchQueue.main.async {
                                if safeSelf.parent.isUpdate{
                                    safeSelf.parent.newImages.append(decodedImage)
                                } else {
                                    safeSelf.parent.images.append(decodedImage)
                                }
                            }
                            
                        }
                    }
                    
                    
                }
            }
        }
    }
}
