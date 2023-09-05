//
//  Extension+UIViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func saveImageToDocument(filename: String, image: UIImage) {

        guard let documentDirectory =
                FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(filename)
        
        guard let data = image.pngData() else { return }
        
                do {
            
            try data.write(to: fileURL)
            
        } catch let error {
            
            print("file save error", error)
            
        }
    }
    
    func loadImageFromDocument(filename:String) -> UIImage {

        guard let documentDirectory =
                FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return UIImage() }
       
        let fileURL = documentDirectory.appendingPathComponent(filename)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage()
        }
    }
    
    func removeImageFromDocument(filename: String) {
        
        guard let documentDirectory =
                FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(filename)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        }
        catch {
            print(error)
        }
    }
}
