//
//  DestinationView.swift
//  Glucosa
//
//  Created by Ricardo on 4/16/17.
//  Copyright © 2017 Ricardo. All rights reserved.
//

import UIKit
import DIOCollectionView

class DestinationCollectionView: DIOCollectionView, DIOCollectionViewDestination {
    
    func receivedDragWithDragInfo(_ dragInfo: DIODragInfo?, andDragState dragState: DIODragState) {
        switch(dragState) {
        case .began:
            self.visibleCells.forEach( { $0.isUserInteractionEnabled = false })
        case .ended:
            self.visibleCells.forEach( { $0.isUserInteractionEnabled = true })
        default:
            break
        }
    }
    
}

class DestinationView: UIView, DIOCollectionViewDestination {
    
    func receivedDragWithDragInfo(_ dragInfo: DIODragInfo?, andDragState dragState: DIODragState) {
        
        print(dragState)
        
        let imageView = self.subviews[0] as! UIImageView
        let item = (dragInfo?.userData as? (String, UIImage))!
        
        switch(dragState) {
        case .began:
            break
        case .ended:
            imageView.image = item.1
        default:
            break
        }
    }
    
    
}


