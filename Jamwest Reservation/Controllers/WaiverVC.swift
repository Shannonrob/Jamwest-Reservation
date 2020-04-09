//
//  WaiverVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import PDFKit
import PencilKit

class WaiverVC: UIViewController, WaiverVCDelegates {
    
//    MARK: - Properties
    var waiverViews = WaiverViews()
    var participantInformation = [ParticipantInformation]()
    let image = #imageLiteral(resourceName: "greenJamwestLogo").withRenderingMode(.alwaysOriginal)
    var pkCanvasView: PKCanvasView!
    
    
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
        
        for info in participantInformation {
            
            print(info.firstName)
        }
        
//        let pdfCreator = PDFCreator(headertitle: waiverViews.headerLabel.text!, image: image, name: "Marlene Smith", hotel: "Grand Palladium", date: "April 2, 2020", time: "9:18 AM", pax: "6", tours: "Zip Line, Horseback Riding, ATV, Driving Experience, Safari, Push kart", voucherNumber: "12345", tourRep: "Lisa", tourComp: "Amstar")
//        
//        pdfCreator.createPDF()
        
        
      pkCanvasView = waiverViews.canvasView
       
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     
    }
    
    override func loadView() {
        
        waiverViews.waiverVCDelegate = self
        view = waiverViews
    }
    
//    MARK: - Selectors
  
    
//    MARK: - Protocols
    
    func handleShowPreviewImageVC(for button: NSObject) {
        
//        self.showAlertSheet(button as! UIButton)
        
//        screenShotScrollview()
//        createPdfFromView()
    }
    
    func handleDoneButton() {
        
        let cameraVC = CameraVC()
        cameraVC.modalPresentationStyle = .fullScreen
        presentDetail(cameraVC)
    }
    
    func handleCancelButton() {
        
        dismissDetail()
    }
    
    func handleClearButton() {
        undoManager?.undo()
    }
    
//    MARK:- Helper Functions
    
    func createPdfFromView() {
        
        let spreadsheetView = waiverViews.containerView
        
        let pageSize = CGSize(width: 612, height: 792)
        
        let pageDimensions = CGRect(x: 0, y: 0, width: spreadsheetView.bounds.width, height: pageSize.height)
        let newPageDimensions = CGRect(x: 0, y: -734, width: spreadsheetView.bounds.width, height: pageSize.height)
        let outputData = NSMutableData()

        UIGraphicsBeginPDFContextToData(outputData, pageDimensions, nil)
    if let context = UIGraphicsGetCurrentContext() {
        
            UIGraphicsBeginPDFPage()
            spreadsheetView.layer.render(in: context)
    }
        if let secondContext = UIGraphicsGetCurrentContext(){
            
            UIGraphicsBeginPDFPageWithInfo(newPageDimensions, nil)
            spreadsheetView.layer.render(in: secondContext)
            
        }
        
    UIGraphicsEndPDFContext()
        
    let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    let documentsFileName = documentDirectories! + "/" + "pdfName.pdf"
    outputData.write(toFile: documentsFileName, atomically: true)
    print(documentsFileName)
    // Reset spreadsheetView
    spreadsheetView.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height)
    spreadsheetView.layoutSubviews()
    spreadsheetView.layoutIfNeeded()
//    spreadsheetView.reloadData()
        
    }
    
    
    
    
    
    
    
    
    
    
    // works best but still cant seem to seperate all pages correctly
    func screenShotScrollview() -> String {

        let scrollView = waiverViews.scrollView
        
        

        let pageDimensions = scrollView.bounds

        let pageSize = pageDimensions.size
        let totalSize = scrollView.contentSize

        let outputData = NSMutableData()

        UIGraphicsBeginPDFContextToData(outputData, .zero, nil)

        var savedContentOffset = scrollView.contentOffset
        let savedContentInset = scrollView.contentInset

        let numberOfPagesThatFitVertivally = Int(ceil(totalSize.height/pageSize.height))
        
        scrollView.contentInset = UIEdgeInsets.zero

        let pageRect = CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height)
        
        print(pageSize.height)
        print("page width \(pageSize.width)")
        
        
        
        if let context = UIGraphicsGetCurrentContext() {
            
            UIGraphicsBeginPDFPageWithInfo(pageRect, nil)
            
                            
            //                let offsetVertical = CGFloat(indexVertical) * pageSize.height
//                            let offsetVertical = CGFloat(indexVertical) * 734
                            
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
//
//                            context.translateBy(x: 0, y: -offsetVertical)

                            scrollView.layer.render(in: context)
            
//            for indexVertical in 0..<numberOfPagesThatFitVertivally {
//
//                UIGraphicsBeginPDFPageWithInfo(origin, nil)
//
////                let offsetVertical = CGFloat(indexVertical) * pageSize.height
//                let offsetVertical = CGFloat(indexVertical) * 734
//
//                scrollView.contentOffset = CGPoint(x: 0, y: offsetVertical)
//
//                context.translateBy(x: 0, y: -offsetVertical)
//
//                scrollView.layer.render(in: context)
//            }
            
            UIGraphicsEndPDFContext()

            scrollView.contentInset = savedContentInset
            scrollView.contentOffset = savedContentOffset
        }

        return self.saveViewPdf(data: outputData)
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
    
    
    func configureUI() {
        
         view.backgroundColor = Constants.Design.Color.Background.FadeGray
    }
}
