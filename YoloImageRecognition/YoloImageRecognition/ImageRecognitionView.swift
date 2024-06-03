//
//  ImageRecognitionView.swift
//  YoloImageRecognition
//
//  Created by Jason Sanchez on 6/3/24.
//

import SwiftUI
import CoreML
import PhotosUI

@State private var probs: [String: Double] = [: ]
@State private var uiImage: UIImage? = UIImage(named: "stop-sign")
@State private var selectedPhotoItem: PhotosPickerItem? = nil
@State private var isCameraSelected: Bool = false

struct ImageRecognitionView: View {
    var body: some View {
        VStack {
            Image(uiImage: uiImage!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
            HStack {
                PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                   Text("Select a Photo")
                }
                
                Button("Camera") {
                    isCameraSelected = true
                }.buttonStyle(.bordered)
            }
            
            Button("Predict") {
                
            }.buttonStyle(.borderedProminent)
            
           
        }
        .onChange(of: selectedPhotoItem, perform: { selectedPhotoItem in
            selectedPhotoItem?.loadTransferable(type: Data.self, completionHandler: { result in
                print(result)
                switch result {
                    case .success(let data):
                        if let data {
                            uiImage = UIImage(data: data)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            })
        })
        .sheet(isPresented: $isCameraSelected, content: {
            ImagePicker(image: $uiImage, sourceType: .camera)
        })
        .padding()
    }
}

#Preview {
    ImageRecognitionView()
}
