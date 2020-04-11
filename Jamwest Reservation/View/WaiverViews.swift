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
    
    lazy var contentViewSize = CGSize(width: 1164, height: 4430 )
    var canvasContainerViewHeight: NSLayoutConstraint?
    var canvasViewHeight: NSLayoutConstraint?
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
    let canvasContainerView = UIView()
    
    let navigationBarView: UIView = {
        
        let view = UIView()
        view.backgroundColor = Constants.Design.Color.Primary.HeavyGreen
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        
        let view = UIScrollView()
        view.backgroundColor = .white
        view.contentSize = contentViewSize
        view.alwaysBounceVertical = true
        view.indicatorStyle = .black
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let containerView: UIView = {

        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let signatureLineView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .lightGray
        view.isHidden = true
        return view
    }()
    
    lazy var canvasView: PKCanvasView = {

        let canvas = PKCanvasView()
        canvas.backgroundColor = .white
        canvas.tool = PKInkingTool(.pen, color: .white, width: 2.5)
        canvas.frame = canvasContainerView.bounds
        canvas.layer.borderWidth = 2
        canvas.layer.borderColor = UIColor.lightGray.cgColor
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
    
    let nameLabel = JamwestWaiverLabelClass()
    let dateLabel = JamwestWaiverLabelClass()
    let voucherLabel = JamwestWaiverLabelClass()
    let tourCompanyLabel = JamwestWaiverLabelClass()
    let tourRepLabel = JamwestWaiverLabelClass()
    let paxLabel = JamwestWaiverLabelClass()
    let toursLabel = JamwestWaiverLabelClass()
    let reservationTimeLabel = JamwestWaiverLabelClass()
    let hotelLabel = JamwestWaiverLabelClass()
    let phoneNumberLabel = JamwestWaiverLabelClass()
    let emailLabel = JamwestWaiverLabelClass()
    let countryLabel = JamwestWaiverLabelClass()
    
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
    
    let signHereLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Sign here"
        label.textColor = .lightGray
        label.isHidden = true
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
        
        let button = UIButton(type: .system)
        button.updateButtonIcon("grayUnselectedCheckMark_Medium")
        button.addTarget(self, action: #selector(handleAgreeButton), for: .touchUpInside)
        return button
    }()
    
    let guardianAcceptButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.updateButtonIcon("grayUnselectedCheckMark_Medium")
        button.addTarget(self, action: #selector(guardianAcceptTapped), for: .touchUpInside)
        return button
    }()
    
    let clearButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: avenirNext_Demibold, size: 16)
        button.isHidden = true
        button.addTarget(self, action: #selector(handleClearTapped), for: .touchUpInside)
        return button
    }()
    
    let cancelButton: JamwestCustomRoundedButton = {
        
        let button = JamwestCustomRoundedButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = Constants.Design.Color.Primary.Orange
        button.addTarget(self, action: #selector(handleCancelTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var doneButton: JamwestCustomRoundedButton = {
        
        let button = JamwestCustomRoundedButton()
        button.setTitle("Done", for: .normal)
        button.isEnabled = false
        button.backgroundColor = Constants.Design.Color.Primary.Green
        button.addTarget(self, action: #selector(handleDoneTapped), for: .touchUpInside)
        return button
    }()

//    MARK: - Handlers
    
    @objc func guardianAcceptTapped() {
        waiverVCDelegate?.handleGuardianAcceptButton()
    }
    
    @objc func handleAgreeButton() {
        waiverVCDelegate?.handleAgreeButton()
    }
    
    @objc func handleDoneTapped() {
        waiverVCDelegate?.handleDoneButton()
    }
    
    @objc func handleCancelTapped() {
        waiverVCDelegate?.handleCancelButton()
    }
    
    @objc func handleClearTapped() {
        waiverVCDelegate?.handleClearButton()
    }
    
    
//    MARK: - Constraints
    
    func configureConstraints() {
        
//        MARK: - Stackviews
        let participantInfoStackViews = UIStackView(arrangedSubviews: [leftParticipantInfoView, rightParticipantInfoView])
        participantInfoStackViews.configureStackView(alignment: .fill, distribution: .fillEqually, spacing: 5)
        participantInfoStackViews.axis = .horizontal
        
        let leftLabelsStackViews = UIStackView(arrangedSubviews: [nameLabel, hotelLabel, reservationTimeLabel, emailLabel,  phoneNumberLabel, countryLabel])
        leftLabelsStackViews.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 0)
        leftLabelsStackViews.axis = .vertical
        
        let rightlabelsStackViews = UIStackView(arrangedSubviews: [dateLabel, voucherLabel, tourRepLabel, tourCompanyLabel, paxLabel, toursLabel])
        rightlabelsStackViews.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 0)
        rightlabelsStackViews.axis = .vertical
        
        let headerStackViews = UIStackView(arrangedSubviews: [headerImage, headerLabel])
        headerStackViews.configureStackView(alignment: .center, distribution: .fillProportionally, spacing: -15)
        headerStackViews.axis = .vertical
        
        let agreeStackView = UIStackView(arrangedSubviews: [agreeButton, agreeLabel])
        agreeStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 5)
        
        let onBehalfStackViews = UIStackView(arrangedSubviews: [guardianAcceptButton, guardianLabel])
        onBehalfStackViews.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 5)
        
        let confirmationStackView = UIStackView(arrangedSubviews: [onBehalfStackViews, agreeStackView])
        confirmationStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 0)
        confirmationStackView.axis = .vertical
        
//        MARK: - ADDSubviews
        addSubview(navigationBarView)
        navigationBarView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
        
        navigationBarView.addSubview(navigationBarTitle)
        navigationBarTitle.anchor(top: navigationBarView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        navigationBarTitle.centerXAnchor.constraint(equalTo: navigationBarView.centerXAnchor).isActive = true
        navigationBarTitle.centerYAnchor.constraint(equalTo: navigationBarView.centerYAnchor).isActive = true
        
        addSubview(scrollViewContainer)
        scrollViewContainer.anchor(top: navigationBarView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        scrollViewContainer.addSubview(scrollView)
        scrollView.anchor(top: scrollViewContainer.topAnchor, left: scrollViewContainer.leftAnchor, bottom: nil
            , right: scrollViewContainer.rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
        scrollView.addSubview(containerView)
        containerView.anchor(top: nil, left: scrollView.frameLayoutGuide.leftAnchor, bottom: nil, right: scrollView.frameLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: scrollView.contentSize.height)
        
        containerView.addSubview(headerStackViews)
        headerStackViews.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        headerImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(participantInfoStackViews)
        participantInfoStackViews.anchor(top: headerStackViews.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 30, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 200)
        
        leftParticipantInfoView.addSubview(leftLabelsStackViews)
        leftLabelsStackViews.anchor(top: leftParticipantInfoView.topAnchor, left: leftParticipantInfoView.leftAnchor, bottom: leftParticipantInfoView.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        rightParticipantInfoView.addSubview(rightlabelsStackViews)
        rightlabelsStackViews.anchor(top: rightParticipantInfoView.topAnchor, left: rightParticipantInfoView.leftAnchor, bottom: rightParticipantInfoView.bottomAnchor, right: rightParticipantInfoView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: participantInfoStackViews.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        containerView.addSubview(confirmationStackView)
        confirmationStackView.anchor(top: textView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollViewContainer.addSubview(canvasContainerView)
        canvasContainerView.backgroundColor = Constants.Design.Color.Background.FadeGray
        canvasContainerView.anchor(top: scrollView.bottomAnchor, left: scrollViewContainer.leftAnchor, bottom: scrollViewContainer.bottomAnchor, right: scrollViewContainer.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        canvasContainerView.addSubview(canvasView)
        canvasView.anchor(top: canvasContainerView.topAnchor, left: canvasContainerView.leftAnchor, bottom: nil, right: canvasContainerView.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)

        canvasContainerView.addSubview(clearButton)
        clearButton.anchor(top: canvasView.topAnchor, left: nil, bottom: nil, right: canvasView.rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 25, width: 0, height: 0)

        canvasContainerView.addSubview(signHereLabel)
        signHereLabel.anchor(top: nil, left: canvasView.leftAnchor, bottom: canvasView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 35, paddingRight: 0, width: 0, height: 0)

        canvasContainerView.addSubview(signatureLineView)
        signatureLineView.anchor(top: nil, left: signHereLabel.rightAnchor, bottom: canvasView.bottomAnchor, right: canvasView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 35, paddingRight: 50, width: 0, height: 0.5)

        addSubview(cancelButton)
        cancelButton.anchor(top: scrollViewContainer.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 20, paddingLeft: 80, paddingBottom: 30, paddingRight: 0, width: 220, height: 60)
        
        addSubview(doneButton)
        doneButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 80, width: 220, height: 60)
        doneButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
    }
}


