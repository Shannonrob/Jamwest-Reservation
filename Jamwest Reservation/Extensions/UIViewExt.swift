//
//  UIViewExt.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat){
         
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
    // Export pdf from Save pdf in drectory and return pdf file path
    func exportAsPdfFromView() -> String {
        
        let pdfPageFrame = self.bounds
        let pdfData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(pdfData, .zero , nil)
        UIGraphicsBeginPDFPageWithInfo(.zero, nil)
        
        UIGraphicsBeginPDFPage()
        renderSize()
        UIGraphicsBeginPDFPage()
        
        UIGraphicsEndPDFContext()
        
        return self.saveViewPdf(data: pdfData)
    }
    
    // Save pdf file in document directory
    func saveViewPdf(data: NSMutableData) -> String {

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("viewPdf.pdf")
        if data.write(to: pdfPath, atomically: true) {
            return pdfPath.path
        } else {
            return ""
        }
    }
    

    func renderSize() {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let width = self.bounds.width
        let height = self.bounds.height
//
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        self.frame = frame
//
//
        context.saveGState()
        
        let rect = context.boundingBoxOfClipPath

        context.translateBy(x: (rect.width - width) / 2 , y: (rect.height - height) / 90)
        
        self.layer.render(in: context)
        context.restoreGState()
    }

}
