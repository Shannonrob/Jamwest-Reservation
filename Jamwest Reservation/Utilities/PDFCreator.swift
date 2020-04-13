//
//  PDFCreator.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 4/2/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import PDFKit

class PDFCreator: NSObject {
    
    let headertitle: String
    let participantName: String
    let participantHotel: String
    let currentDate: String
    let reservationTime: String
    let reservationPax: String
    let reservedTours: String
    let voucherNumber: String
    let tourRepresentative: String
    let tourCompany: String
    let image: UIImage
    
    init(headertitle: String, image: UIImage, name: String, hotel: String, date: String, time: String, pax: String, tours: String, voucherNumber: String, tourRep: String, tourComp: String) {
      self.headertitle = headertitle
      self.image = image
        self.participantName = name
        self.participantHotel = hotel
        self.currentDate = date
        self.reservationTime = time
        self.reservationPax = pax
        self.reservedTours = tours
        self.voucherNumber = voucherNumber
        self.tourRepresentative = tourRep
        self.tourCompany = tourComp
    }
    
    func createPDF() {
        
        // 1
        let pdfMetaData = [
            kCGPDFContextCreator: "Jamwest",
            kCGPDFContextAuthor: "",
            kCGPDFContextTitle: "Test"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageSize = CGSize(width: 612, height: 792)
        let pageRect = CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { (context) in
            
            context.beginPage()
            
            let imageBottom = addImage(pageRect: pageRect, imageTop: 30)
            let warningTitle = addWarningLabel(pageRect: pageRect, warningLabelTop: imageBottom)
            let leftReservationInfoLabel = addLeftInfoLabels(pageRect: pageRect, reservationInfoLabelsTop: warningTitle + 40)
            let rightReservationInfoLabel = addRightInfoLabels(pageRect: pageRect, reservationInfoLabelsTop: warningTitle + 40)
            
            context.beginPage()
            addView(pageRect: pageRect, viewTop: 10)
        }
        
        // Save pdf file in document directory
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("JamwestWaver.pdf")
        
        do {
            try data.write(to: pdfPath)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func addImage(pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
      // 1
      let maxHeight = pageRect.height * 0.2
      let maxWidth = pageRect.width * 0.4
      // 2
      let aspectWidth = maxWidth / image.size.width
      let aspectHeight = maxHeight / image.size.height
      let aspectRatio = min(aspectWidth, aspectHeight)
      // 3
      let scaledWidth = image.size.width * aspectRatio
      let scaledHeight = image.size.height * aspectRatio
      // 4
      let imageX = (pageRect.width - scaledWidth) / 2
      let imageRect = CGRect(x: imageX, y: imageTop,
                             width: scaledWidth, height: scaledHeight)
      // 5
      image.draw(in: imageRect)
      return imageRect.origin.y + imageRect.size.height
    }
    
    func addWarningLabel(pageRect: CGRect, warningLabelTop: CGFloat) -> CGFloat {
      // 1
        let titleFont = UIFont.init(name: helveticaNeue_Bold, size: 8)
        let titleColor = UIColor.darkText
      // 2
      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont!, NSAttributedString.Key.foregroundColor: titleColor]
      // 3
      let attributedTitle = NSAttributedString(
        string: headertitle,
        attributes: titleAttributes
      )
      // 4
      let titleStringSize = attributedTitle.size()
      // 5
      let titleStringRect = CGRect(
        x: (pageRect.width - titleStringSize.width) / 2.0,
        y: warningLabelTop,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      // 6
      attributedTitle.draw(in: titleStringRect)
      // 7
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    
    func addLeftInfoLabels(pageRect: CGRect, reservationInfoLabelsTop: CGFloat) -> CGFloat {
      
        let name = "Name : \(participantName)"
        let hotel = "Hotel : \(participantHotel)"
        let date = "Date : \(currentDate)"
        let time = "Time : \(reservationTime)"
        let pax = "Pax : \(reservationPax)"
        
        let titleFont = UIFont.init(name: helveticaNeue_Medium , size: 10)
        let titleColor = UIColor.darkText
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: titleFont!, NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        let formattedNameText = NSMutableAttributedString(string: name, attributes: textAttributes)
        let formattedhotetText = NSMutableAttributedString(string: hotel, attributes: textAttributes)
        let formattedDateText = NSMutableAttributedString(string: date, attributes: textAttributes)
        let formattedTimeText = NSMutableAttributedString(string: time, attributes: textAttributes)
        let formattedPaxText = NSMutableAttributedString(string: pax, attributes: textAttributes)
        
//        let nameStringSize = formattedNameText.size()
        let hotelStringSize = formattedhotetText.size()
        let dateStringSize = formattedDateText.size()
        let timeStringSize = formattedTimeText.size()
        let paxStringSize = formattedPaxText.size()
        
        let titleStringRect = CGRect(x: 107, y: reservationInfoLabelsTop, width: pageRect.width - 370, height: pageRect.height - reservationInfoLabelsTop - pageRect.height / 5)
        let hotelStringRect = CGRect(x: 107, y: titleStringRect.minY + 20, width: hotelStringSize.width, height: hotelStringSize.height)
        let dateStringRect = CGRect(x: 107, y: hotelStringRect.minY + 20, width: dateStringSize.width, height: dateStringSize.height)
        let timeStringRect = CGRect(x: 107, y: dateStringRect.minY + 20, width: timeStringSize.width, height: timeStringSize.height)
        let paxStringRect = CGRect(x: 107, y: timeStringRect.minY + 20, width: paxStringSize.width, height: paxStringSize.height)
        
        formattedNameText.draw(in: titleStringRect)
        formattedhotetText.draw(in: hotelStringRect)
        formattedDateText.draw(in: dateStringRect)
        formattedTimeText.draw(in: timeStringRect)
        formattedPaxText.draw(in: paxStringRect)
        
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addRightInfoLabels(pageRect: CGRect, reservationInfoLabelsTop: CGFloat) -> CGFloat {
      
        let tours = "Tour(s) : \(reservedTours)"
        let voucher = "Voucher # : \(voucherNumber)"
        let tourRep = "Tour Representative : \(tourRepresentative)"
        let tourComp = "Tour Company : \(tourCompany)"
        
        let titleFont = UIFont.init(name: helveticaNeue_Medium , size: 10)
        let titleColor = UIColor.darkText
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: titleFont!, NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        let formattedTourText = NSMutableAttributedString(string: tours, attributes: textAttributes)
        let formattedVoucherText = NSMutableAttributedString(string: voucher, attributes: textAttributes)
        let formattedTourRepText = NSMutableAttributedString(string: tourRep, attributes: textAttributes)
        let formattedTourCompText = NSMutableAttributedString(string: tourComp, attributes: textAttributes)
        
        let voucherStringSize = formattedVoucherText.size()
        let tourRepStringSize = formattedTourRepText.size()
        let tourCompStringSize = formattedTourCompText.size()
        
        let voucherStringRect = CGRect(x: 350, y: reservationInfoLabelsTop, width: voucherStringSize.width, height: voucherStringSize.height)
        let tourRepStringRect = CGRect(x: 350, y: voucherStringRect.minY + 20, width: tourRepStringSize.width, height: tourRepStringSize.height)
        let tourCompStringRect = CGRect(x: 350, y: tourRepStringRect.minY + 20, width: tourCompStringSize.width, height: tourCompStringSize.height)
        let tourStringRect = CGRect(x: 350, y: tourCompStringRect.minY + 20, width: pageRect.width - 370, height: pageRect.height - reservationInfoLabelsTop - pageRect.height / 5)
        
        formattedVoucherText.draw(in: voucherStringRect)
        formattedTourRepText.draw(in: tourRepStringRect)
        formattedTourCompText.draw(in: tourCompStringRect)
        formattedTourText.draw(in: tourStringRect)
        
      return tourStringRect.origin.y + tourStringRect.size.height
    }
    
    func addView(pageRect: CGRect, viewTop: CGFloat) -> CGFloat {
      
        let view: JamwestDefaultView = {
            
            let view = JamwestDefaultView()
            view.backgroundColor = .systemPink
            return view
        }()
        
      // 4
//        let viewSize = view.f size()
      // 5
      let titleStringRect = CGRect(
        x: (pageRect.width) / 2.0,
        y: viewTop,
        width: 50,
        height: 100
      )
      // 6
//        view.draw(titleStringRect)
//        view.layer.draw(in: <#T##CGContext#>)
      // 7
      return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    
    
    
    
}
