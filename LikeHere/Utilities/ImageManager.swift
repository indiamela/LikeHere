//
//  ImageManager.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/24.
//

import Foundation
import FirebaseStorage

class ImageManager {
    static let instance = ImageManager()
    private var REF_STOR = Storage.storage()

    func uploadProfileImage(userID: String, image: UIImage){
        
        let path = getProfileImagePath(userID: userID)
        
        uploadImage(path: path, image: image) { (_) in}
    }
    
    // MARK: PRIVATE FUNCTIONS
    // Functions we call from this file only
    
    private func getProfileImagePath(userID: String)-> StorageReference {
        let userPath = "users/\(userID)/profile"
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
    }
    
    private func uploadImage(path: StorageReference, image: UIImage, handler: @escaping(_ success: Bool)-> ()){
        
        
        var compression: CGFloat = 1.0 //Loops down by 0.05
        let maxFileSize: Int = 240 * 240 // Maximum file size that we want to save
        let maxCompression: CGFloat = 0.05 // Maximum compression we ever allow
        
        // Get image data
        guard var originalData = image.jpegData(compressionQuality: 1.0) else {
            print("Error getting data from image")
            handler(false)
            return
        }
        
        // Check maximum file size
        while (originalData.count > maxFileSize) && (compression > maxCompression) {
            compression -= 0.05
            if let compressedData = image.jpegData(compressionQuality: compression){
                originalData = compressedData
            }
            print(compression)
        }
        
        
        // Get image data
        guard let finaleData = image.jpegData(compressionQuality: 1.0) else {
            print("Error getting data from image")
            handler(false)
            return
        }
        
        // Get photo metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Save data to path
        path.putData(finaleData, metadata: metadata, completion:{ (_, error) in
                     
            if let error = error {
                //Error
                print("Error uploading image. \(error)")
            } else {
                //Success
                print("Success uploading image")
                handler(true)
                return
            }
        
        })
    }
}

