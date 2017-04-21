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

class DestinationCollectionView3: DIOCollectionView, DIOCollectionViewDestination {
    
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

class DestinationView3: UIView, DIOCollectionViewDestination {
    func receivedDragWithDragInfo(_ dragInfo: DIODragInfo?, andDragState dragState: DIODragState) {
        
        print(dragState)
        
        let imageView = self.subviews[0] as! UIImageView
        let item = (dragInfo?.userData as? (Int, UIImage))!
        
        switch(dragState) {
        case .began:
            break
        case .ended:
            imageView.tag = item.0
            imageView.image = item.1
            GameManager.sharedInstance.counter3 += 1
            print(GameManager.sharedInstance.counter3)
            if GameManager.sharedInstance.counter3 == 4 {
                NotificationCenter.default.post(name: Notification.Name("game3HasEndedNotification"), object: nil)
                print("Ya mandé la notification")
                GameManager.sharedInstance.counter3 = 0
            }
            
        default:
            break
        }
    }
    
    
}


