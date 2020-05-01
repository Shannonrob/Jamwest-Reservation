//
//  UIScrollViewExt.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/25/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

extension UIScrollView {

    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }

    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }

    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }

    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
    
    
    enum ScrollDirection {
        case Top
        case Right
        case Bottom
        case Left
        
        func contentOffsetWith(scrollView: UIScrollView) -> CGPoint {
            var contentOffset = CGPoint.zero
            switch self {
                case .Top:
                    contentOffset = CGPoint(x: 0, y: -scrollView.contentInset.top)
                case .Right:
                    contentOffset = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.size.width, y: 0)
                case .Bottom:
                    contentOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
                case .Left:
                    contentOffset = CGPoint(x: -scrollView.contentInset.left, y: 0)
            }
            return contentOffset
        }
    }
}
