//
//  WaiverViews.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/23/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import CoreText
import PencilKit

class WaiverViews: UIView {

//    MARK: - Properties
    
    lazy var contentViewSize = CGSize(width: 1164, height: 4815 )
    weak var waiverVCDelegate: WaiverVCDelegates?
    
//    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        // initialize constraints/views here
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - UIViews
    
    let scrollViewContainer = JamwestDefaultView()
    let leftParticipantInfoView = JamwestDefaultView ()
    let rightParticipantInfoView = JamwestDefaultView()
    let signatureCanvasContainerView = UIView()
//    let canvasView = PKCanvasView()
 
    
    let navigationBarView: UIView = {
        
        let view = UIView()
        view.backgroundColor = Constants.Design.Color.Primary.HeavyGreen
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        
        let view = UIScrollView()
        view.backgroundColor = .white
//        view.backgroundColor = .systemTeal
        view.contentSize = contentViewSize
        view.alwaysBounceVertical = true
        view.indicatorStyle = .black
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let containerView: UIView = {
        // the view inside the scrollView
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let seperatorView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var canvasView: PKCanvasView = {

        let canvas = PKCanvasView()
        canvas.backgroundColor = .lightGray
        canvas.tool = PKInkingTool(.pen, color: .systemOrange, width: 10)
        canvas.frame = signatureCanvasContainerView.bounds
        return canvas
    }()
    
//    MARK: - UIImageView
    
    let headerImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "greenJamwestLogo").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
//    MARK: - UILabels
    
    let navigationBarTitle: UILabel = {
        
        let label = UILabel()
        label.text = "Waiver & Release of Liability"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    let headerLabel: UILabel = {
        
        let label = UILabel()
        label.text = "WARNING, ASSUMPTION OF RISK, LIABILITY RELEASE, INDEMNITY AND HOLD HARMLESS AGREEMENT"
        label.font = UIFont.init(name: helveticaNeue_Bold, size: 14)
        label.textColor = .darkText
        return label
    }()
    
    let nameLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Name :"
        return label
    }()
    
    let dateLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Date :"
        return label
    }()
    
    let voucherLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Voucher # :"
        return label
    }()
    
    let tourCompanyLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Tour Company :"
        return label
    }()
    
    let tourRepLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Tour Representative :"
        return label
    }()
    
    let paxLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Pax :"
        return label
    }()
    
    let toursLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Tour(s) :"
        return label
    }()
    
    let reservationTimeLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Time :"
        return label
    }()
    
    let hotelLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Hotel :"
        return label
    }()

    let agreeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "I confirm that I have read, understand and agree to the terms and condition"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    let guardianLabel: UILabel = {
        
        let label = UILabel()
        label.text = "I parentName is signing this waiver of liability on the behalf of minorName"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    
//    MARK: - UITextView
    
    lazy var textView: UITextView = {
        
        let textView = UITextView()
        let url = Bundle.main.url(forResource: "JamwestWaiver", withExtension: "rtf")!
        let opts : [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.rtf]
        var dictionary: NSDictionary? = nil
        let waiverText = try! NSAttributedString(url: url, options: opts, documentAttributes: &dictionary)
        
        textView.backgroundColor = .white
        textView.textColor = .darkText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.init(name: helveticaNeue_Medium, size: 18)
        textView.textAlignment = .center
        textView.attributedText = waiverText
        return textView
    }()
    
    
//    MARK: - UIButton
    
    let agreeButton: UIButton = {
        
        let button = UIButton()
        button.updateButtonIcon("grayUncheckMark")
        button.addTarget(self, action: #selector(handleAgreeButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    let onBehalfButton: UIButton = {
        
        let button = UIButton()
        button.updateButtonIcon("grayUncheckMark")
        button.addTarget(self, action: #selector(handleAgreeButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    let cancelButton: JamwestCustomRoundedButton = {
        
        let button = JamwestCustomRoundedButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = Constants.Design.Color.Primary.Orange
        return button
    }()
    
    lazy var doneButton: JamwestCustomRoundedButton = {
        
        let button = JamwestCustomRoundedButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = UIColor(red: 53/255, green: 109/255, blue: 240/255, alpha: 1)
        return button
    }()

//    MARK: - Handlers
    
    
    
    @objc func handleAgreeButton(sender: UIButton) {

//        let pdf = leftParticipantInfoView.exportAsPdfFromView()
//        print(pdf)
//        waiverVCDelegate?.handleShowPreviewImageVC(for: sender)
    }
    
    
    
//    MARK: - Constraints
    
    func configureConstraints() {
        
        // stackViews
        let participantInfoStackViews = UIStackView(arrangedSubviews: [leftParticipantInfoView, rightParticipantInfoView])
        participantInfoStackViews.configureStackView(alignment: .fill, distribution: .fillEqually, spacing: 5)
        participantInfoStackViews.axis = .horizontal
        
        let leftLabelsStackViews = UIStackView(arrangedSubviews: [nameLabel, hotelLabel, dateLabel, reservationTimeLabel, paxLabel])
        leftLabelsStackViews.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 0)
        leftLabelsStackViews.axis = .vertical
        
        let rightlabelsStackViews = UIStackView(arrangedSubviews: [toursLabel, voucherLabel, tourRepLabel, tourCompanyLabel])
        rightlabelsStackViews.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 0)
        rightlabelsStackViews.axis = .vertical
        
        let headerStackViews = UIStackView(arrangedSubviews: [headerImage, headerLabel])
        headerStackViews.configureStackView(alignment: .center, distribution: .fillProportionally, spacing: -15)
        headerStackViews.axis = .vertical
        
        let agreeStackView = UIStackView(arrangedSubviews: [agreeButton, agreeLabel])
        agreeStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 5)
        
        let onBehalfStackViews = UIStackView(arrangedSubviews: [onBehalfButton, guardianLabel])
        onBehalfStackViews.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 5)

        let confirmationStackView = UIStackView(arrangedSubviews: [agreeStackView, onBehalfStackViews])
        confirmationStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 0)
        confirmationStackView.axis = .vertical
        
        // subviews
        addSubview(navigationBarView)
        navigationBarView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
        
        navigationBarView.addSubview(navigationBarTitle)
        navigationBarTitle.anchor(top: navigationBarView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        navigationBarTitle.centerXAnchor.constraint(equalTo: navigationBarView.centerXAnchor).isActive = true
        navigationBarTitle.centerYAnchor.constraint(equalTo: navigationBarView.centerYAnchor).isActive = true
        
        addSubview(scrollViewContainer)
        scrollViewContainer.anchor(top: navigationBarView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)

        scrollViewContainer.addSubview(scrollView)
        scrollView.anchor(top: scrollViewContainer.topAnchor, left: scrollViewContainer.leftAnchor, bottom: scrollViewContainer.bottomAnchor, right: scrollViewContainer.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)

        scrollView.addSubview(containerView)
        containerView.anchor(top: nil, left: scrollView.frameLayoutGuide.leftAnchor, bottom: nil, right: scrollView.frameLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: scrollView.contentSize.height)

        containerView.addSubview(headerStackViews)
        headerStackViews.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        headerImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

        
        //this in temporary
//        containerView.addSubview(testButton)
//        testButton.anchor(top: headerStackViews.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 1500, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)


        
        containerView.addSubview(participantInfoStackViews)
        participantInfoStackViews.anchor(top: headerStackViews.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 30, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 230)

        leftParticipantInfoView.addSubview(leftLabelsStackViews)
        leftLabelsStackViews.anchor(top: leftParticipantInfoView.topAnchor, left: leftParticipantInfoView.leftAnchor, bottom: leftParticipantInfoView.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)

        rightParticipantInfoView.addSubview(rightlabelsStackViews)
        rightlabelsStackViews.anchor(top: rightParticipantInfoView.topAnchor, left: rightParticipantInfoView.leftAnchor, bottom: rightParticipantInfoView.bottomAnchor, right: rightParticipantInfoView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)

        containerView.addSubview(textView)
        textView.anchor(top: participantInfoStackViews.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        containerView.addSubview(seperatorView)
        seperatorView.anchor(top: textView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 0.5)
        
        containerView.addSubview(confirmationStackView)
        confirmationStackView.anchor(top: seperatorView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        containerView.addSubview(signatureCanvasContainerView)
        signatureCanvasContainerView.anchor(top: confirmationStackView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        signatureCanvasContainerView.addSubview(canvasView)
        canvasView.anchor(top: signatureCanvasContainerView.topAnchor, left: signatureCanvasContainerView.leftAnchor, bottom: signatureCanvasContainerView.bottomAnchor, right: signatureCanvasContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        containerView.addSubview(cancelButton)
        cancelButton.anchor(top: signatureCanvasContainerView.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 80, paddingBottom: 20, paddingRight: 0, width: 160, height: 60)
        
        containerView.addSubview(doneButton)
        doneButton.anchor(top: nil, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 80, width: 160, height: 60)
        doneButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
    }
}
