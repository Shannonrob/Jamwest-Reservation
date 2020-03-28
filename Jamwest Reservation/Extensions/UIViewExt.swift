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
    
    
//    // Export pdf from Save pdf in drectory and return pdf file path
//    func exportAsPdfFromViewTest() -> String {
//
//        let printFormatter = self.viewPrintFormatter()
//
//        let renderer = UIPrintPageRenderer()
//        renderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
//
//
//        let pdfData = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
//        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
//        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
//        self.layer.render(in: pdfContext)
//        UIGraphicsEndPDFContext()
//        return self.saveViewPdf(data: pdfData)
//
//    }
//

    
    func customPDF() {
        
        let printFormatter = self.viewPrintFormatter()
        
        let renderer = UIPrintPageRenderer()
        renderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        
        let pageSize = CGSize(width: 612, height: 792)
        let pageMargins = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
        let printableRect = CGRect(x: pageMargins.left, y: pageMargins.top
            , width: pageSize.width - pageMargins.left, height: pageSize.height - pageMargins.top - pageMargins.bottom)
        
        let paperRect = CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height)
        
        renderer.setValue(NSValue(cgRect: paperRect), forKey: "paperRect")
        renderer.setValue(NSValue(cgRect: printableRect), forKey: "printableRect")
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, paperRect, nil)
        renderer.prepare(forDrawingPages: NSMakeRange(0, renderer.numberOfPages))
        
        
        let pdfScale = (self.frame.width/paperRect.size.width) / 3.75
       
        let pdfTranslate = (self.bounds.width - self.bounds.width) / 2
        
        let width = self.frame.width
        let height = self.frame.height
        
        if let context = UIGraphicsGetCurrentContext() {
            
            let bounds = UIGraphicsGetPDFContextBounds()
            
            for i in 0..<renderer.numberOfPages {
                
                UIGraphicsBeginPDFPage()
                
                context.saveGState()
                
                let rect = context.boundingBoxOfClipPath
                
                context.translateBy(x: (rect.width + width) / 145 , y: (rect.height + height) / 625)
                
                context.scaleBy(x: pdfScale, y: pdfScale)
                
                
              
                
                
                
                renderer.drawPage(at: i, in: bounds)
                self.layer.render(in: context)
                
                context.restoreGState()
            }
        }
        
    
        UIGraphicsEndPDFContext()
        
        // Save pdf file in document directory
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("SatTest2.pdf")
        
        do {
            try pdfData.write(to: pdfPath)
        } catch {
            print(error.localizedDescription)
        }

        
//        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
//        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
//        self.layer.render(in: pdfContext)
//        UIGraphicsEndPDFContext()
        
    }













    // prints 6 pages but all the same
    // Export pdf from Save pdf in drectory and return pdf file path
    func exportAsPdfFromView() -> String {
        
        let pdfPageFrame = self.bounds
        let pdfData = NSMutableData()
        
        // page size
        let pageDimensions = self.bounds

        // divide scrollView dimensions to figure how many pages are needed
        let pageSize = pageDimensions.size
//        let totalSize = self.frame
        let numberOfPagesThatFitHorizontally = Int(ceil(1164 / pageSize.width))
        let numberOfPagesThatFitVertically = Int(ceil(6 / 1))

        
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
//        UIGraphicsBeginPDFPageWithInfo(.zero, nil)
//        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
        
        
        
        if let context = UIGraphicsGetCurrentContext() {
            
            for indexHorizontal in 0 ..< numberOfPagesThatFitHorizontally {
                
                print("horizontal count is \(indexHorizontal)")
                for indexVertical in 0 ..< numberOfPagesThatFitVertically {

                    print("vertical count is \(indexVertical)")
                    
                    UIGraphicsBeginPDFPage()
                
//                    let offsetHorizontal = CGFloat(indexHorizontal) * pageSize.width
//                    let offsetVertical = CGFloat(indexVertical) * pageSize.height
//
//                    scrollView.contentOffset = CGPoint(x: offsetHorizontal, y: offsetVertical)
//                    context.translateBy(x: -offsetHorizontal, y: -offsetVertical)
                    
                    self.layer.render(in: context)
                }
            }
        }
        
//        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        return self.saveViewPdf(data: pdfData)
        
    }
    
//    // Export pdf from Save pdf in drectory and return pdf file path
//    func exportAsPdfFromView() -> String {
//
//        let pdfPageFrame = self.bounds
//        let pdfData = NSMutableData()
//
//        UIGraphicsBeginPDFContextToData(pdfData, .zero , nil)
//        UIGraphicsBeginPDFPageWithInfo(.zero, nil)
//
//        UIGraphicsBeginPDFPage()
//        renderSize()
//        UIGraphicsBeginPDFPage()
//
//        UIGraphicsEndPDFContext()
//
//        return self.saveViewPdf(data: pdfData)
//    }
//
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
