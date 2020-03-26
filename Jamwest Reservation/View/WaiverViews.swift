//
//  WaiverViews.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/23/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class WaiverViews: UIView {

//    MARK: - Properties
    
    lazy var contentViewSize = CGSize(width: self.scrollViewContainer.frame.width, height: self.scrollViewContainer.frame.height + 5000 )
    
//    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureConstraints()
        scrollToBottomCheck()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        // initialize constraints/views here
        configureConstraints()
        scrollToBottomCheck()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - UIViews
    
    let scrollViewContainer = JamwestDefaultView()
    let leftParticipantInfoView = JamwestDefaultView ()
    let rightParticipantInfoView = JamwestDefaultView()
    let signatureContentsView = JamwestDefaultView()
    
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
        return view
    }()
    
    let containerView: UIView = {
        // the view inside the scrollView
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let signatureView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        return view
    }()
    
    
//    MARK: - UIImageView
    
    let headerImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "greenJamwestLogo  ").withRenderingMode(.alwaysOriginal)
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
        label.text = "Tour/s :"
        return label
    }()
    
    let reservationTimeLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Resevation Time :"
        return label
    }()
    
    let hotelLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Hotel :"
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
    
    
    
    func scrollToBottomCheck() {
        
        if scrollView.isAtBottom {
            
            print("reached bottom")
            
        }
    }
    
//    MARK: - Constraints
    
    func configureConstraints() {
        
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
        containerView.anchor(top: nil, left: scrollView.frameLayoutGuide.leftAnchor, bottom: nil, right: scrollView.frameLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: scrollView.frame.width, height: scrollView.frame.height)
        
        containerView.addSubview(headerStackViews)
        headerStackViews.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        headerStackViews.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(participantInfoStackViews)
        participantInfoStackViews.anchor(top: headerStackViews.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 230)

        leftParticipantInfoView.addSubview(leftLabelsStackViews)
        leftLabelsStackViews.anchor(top: leftParticipantInfoView.topAnchor, left: leftParticipantInfoView.leftAnchor, bottom: leftParticipantInfoView.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)

        rightParticipantInfoView.addSubview(rightlabelsStackViews)
        rightlabelsStackViews.anchor(top: rightParticipantInfoView.topAnchor, left: rightParticipantInfoView.leftAnchor, bottom: rightParticipantInfoView.bottomAnchor, right: rightParticipantInfoView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)

        containerView.addSubview(textView)
        textView.anchor(top: participantInfoStackViews.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
//
//        view.addSubview(signatureView)
//        signatureView.anchor(top: signatureContentsView.topAnchor, left: signatureContentsView.leftAnchor, bottom: nil, right: signatureContentsView.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 180)
        
    }

}
