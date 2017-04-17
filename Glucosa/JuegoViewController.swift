//
//  JuegoViewController.swift
//  Glucosa
//
//  Created by Ricardo on 4/16/17.
//  Copyright © 2017 Ricardo. All rights reserved.
//

import UIKit
import DIOCollectionView
import SCLAlertView


class JuegoViewController: UIViewController {
    
    @IBOutlet weak var collectionView1: DIOCollectionView!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    
    var items1 = [(10, UIImage(named:"celulosa")!),
                  (20, UIImage(named:"celobiosa")!),
                  (30, UIImage(named:"glucosa")!)]
    
    var itemsAux = [(Int, UIImage)]()

    
    
    func itemsForCollectionView(collectionView: UICollectionView) -> [(Int, UIImage)] {
        if(collectionView == collectionView1) {
            //items1 = itemsAux
            return items1
        }
        return []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.dioDataSource = self
        collectionView1.dioDelegate = self
        
        itemsAux = items1
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload(){
        imageView1.image = UIImage()
        imageView2.image = UIImage()
        imageView3.image = nil
    }

}

extension JuegoViewController: DIOCollectionViewDelegate {
    func dioCollectionView(_ dioCollectionView: DIOCollectionView,
                           draggedItemAtIndexPath indexPath: IndexPath,
                           withDragState dragState: DIODragState) {
        switch(dragState) {
            
       // case .began:
            //self.items1.remove(at: indexPath.row)
            //self.collectionView1.deleteItems(at: [indexPath])
            
        case .ended:
            items1.remove(at: indexPath.row)
            collectionView1.deleteItems(at: [indexPath])
            
        default:
            break
        }
    }
}

extension JuegoViewController: DIOCollectionViewDataSource {
    func dioCollectionView(_ dioCollectionView: DIOCollectionView,
                           userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        let cellData = itemsForCollectionView(collectionView: dioCollectionView)[indexPath.row]
        return cellData
    }
}

extension JuegoViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let imageView  = cell.subviews[0].subviews[0] as! UIImageView
        //let label = cell.subviews[0].subviews[1] as! UILabel
        
        let item = itemsForCollectionView(collectionView: collectionView)[indexPath.row]
        print(item)
        
        
        //label.text = "\(item.0)"
        imageView.image = item.1
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsForCollectionView(collectionView: collectionView).count
        
    }
}

extension JuegoViewController: UICollectionViewDelegate {}

private extension JuegoViewController {
    func checkIfImagesInOrder() {
        if(imageView1.tag == 10 && imageView2.tag == 20 || imageView2.tag == 20 && imageView3.tag == 30 || imageView1.tag == 10 && imageView3.tag == 30){
            
            
            
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Siguiente Nivel") {
                
                //Instantiate next VC
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Juego2ViewController") as? Juego2ViewController {
                    if let navigator = self.navigationController {
                        navigator.pushViewController(viewController, animated: true)
                    }
                }
            }
            
            alertView.showSuccess("Correcto", subTitle: ":)")
            print("correcto")
            
           
            
        } else {
            SCLAlertView().showError("Incorrecto", subTitle: ":(")
            print("incorrecto")
            reload()
            print(items1)
            items1 = itemsAux
            print(itemsAux)
            self.collectionView1.reloadData()
            
        }
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.gameHasEnded), name: Notification.Name("gameHasEndedNotification"), object: nil)
    }
    
    @objc func gameHasEnded() {
        checkIfImagesInOrder()
    }
}
