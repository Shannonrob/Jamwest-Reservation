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
    
    func setShadow() {
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2.75
        layer.shadowOpacity = 1.0
    }
    
    
    
    // do not delete
//    func customPDF() {
//
//        let printFormatter = self.viewPrintFormatter()
//
//        let renderer = UIPrintPageRenderer()
//        renderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
//
//
//        let pageSize = CGSize(width: 612, height: 792)
//        let pageMargins = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
//        let printableRect = CGRect(x: pageMargins.left, y: pageMargins.top
//            , width: pageSize.width - pageMargins.left, height: pageSize.height - pageMargins.top - pageMargins.bottom)
//
//        let paperRect = CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height)
//
//        renderer.setValue(NSValue(cgRect: paperRect), forKey: "paperRect")
//        renderer.setValue(NSValue(cgRect: printableRect), forKey: "printableRect")
//
//        let pdfData = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, paperRect, nil)
//        renderer.prepare(forDrawingPages: NSMakeRange(0, renderer.numberOfPages))
//
//
//        let pdfScale = (self.frame.width/paperRect.size.width) / 3.75
//    //    let pdfScale = (self.bounds.height/paperRect.height) / 7
//
//        let width = self.frame.width
//        let height = self.frame.height
//
//        if let context = UIGraphicsGetCurrentContext() {
//
////            let bounds = UIGraphicsGetPDFContextBounds()
//
//            for _ in 0..<renderer.numberOfPages {
//
//                UIGraphicsBeginPDFPage()
//
//                context.saveGState()
//
//                let rect = context.boundingBoxOfClipPath
//
////                context.translateBy(x: (rect.width + width) / 145 , y: (rect.height + height) / 625)
//                context.translateBy(x: 0, y: 0 )
//
//                context.scaleBy(x: pdfScale, y: pdfScale)
//
//                self.layer.render(in: context)
//
//                context.restoreGState()
//            }
//        }
//
//
//        UIGraphicsEndPDFContext()
//
//        // Save pdf file in document directory
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let docDirectoryPath = paths[0]
//        let pdfPath = docDirectoryPath.appendingPathComponent("Thursdaytest.pdf")
//
//        do {
//            try pdfData.write(to: pdfPath)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//
//    }
    
    
//    
//    func exportAsPdfFromView() -> String {
//        
//        let pdfPageFrame = self.bounds
//        let pdfData = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
//        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
//        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
//        self.layer.render(in: pdfContext)
//        UIGraphicsEndPDFContext()
//        return self.saveViewPdf(data: pdfData)
//        
//    }
    
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
        
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        self.frame = frame


        context.saveGState()
        
        let rect = context.boundingBoxOfClipPath

        context.translateBy(x: (rect.width - width) / 2 , y: (rect.height - height) / 90)
        
        self.layer.render(in: context)
        context.restoreGState()
    }

}
