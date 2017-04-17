//
//  DestinationView2.swift
//  Glucosa
//
//  Created by Ricardo on 4/16/17.
//  Copyright © 2017 Ricardo. All rights reserved.
//

//
//  DestinationView.swift
//  Glucosa
//
//  Created by Ricardo on 4/16/17.
//  Copyright © 2017 Ricardo. All rights reserved.
//

import UIKit
import DIOCollectionView

class DestinationCollectionView2: DIOCollectionView, DIOCollectionViewDestination {
    
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

class DestinationView2: UIView, DIOCollectionViewDestination {
    func receivedDragWithDragInfo(_ dragInfo: DIODragInfo?, andDragState dragState: DIODragState) {
        
        print(dragState)
        
        let label = self.subviews[0] as! UILabel
        let item = (dragInfo?.userData as? (Int, String))!
        
        switch(dragState) {
        case .began:
            break
        case .ended:
            label.tag = item.0
            label.text = item.1
            GameManager.sharedInstance.counter2 += 1
            
            if GameManager.sharedInstance.counter2 == 3 {
                NotificationCenter.default.post(name: Notification.Name("gameHasEndedNotification2"), object: nil)
                GameManager.sharedInstance.counter2 = 0
            }
            
        default:
            break
        }
    }
    
    
}


