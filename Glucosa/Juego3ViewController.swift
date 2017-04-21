//
//  Juego3ViewController.swift
//  Glucosa
//
//  Created by Ricardo on 4/21/17.
//  Copyright © 2017 Ricardo. All rights reserved.
//

import UIKit
import DIOCollectionView
import SCLAlertView

class Juego3ViewController: UIViewController {

    @IBOutlet weak var imageViewGlucosa: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var collectionView1: DIOCollectionView!
    var items1 = [(10, UIImage(named:"oh")!),
                  (20, UIImage(named:"a")!),
                  (40, UIImage(named:"o")!),
                  (30, UIImage(named:"cho")!)]
    
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
        addObservers3()
        imageViewGlucosa.image = UIImage(named: "B14Glucanasa")
        
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
        imageView3.image = UIImage()
        imageView4.image = UIImage()
    }
}
extension Juego3ViewController: DIOCollectionViewDelegate {
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

extension Juego3ViewController: DIOCollectionViewDataSource {
    func dioCollectionView(_ dioCollectionView: DIOCollectionView,
                           userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        let cellData = itemsForCollectionView(collectionView: dioCollectionView)[indexPath.row]
        return cellData
    }
}

extension Juego3ViewController: UICollectionViewDataSource {
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

extension Juego3ViewController: UICollectionViewDelegate {}

private extension Juego3ViewController {
    func checkIfImagesInOrder3() {
        
        //FALTA CHECAR EL ORDEN
        print("imageView1 tag")
        print(imageView1.tag)
        print("imageView2 tag")
        print(imageView2.tag)
        print("imageView3 tag")
        print(imageView3.tag)
        print("imageView4 tag")
        print(imageView4.tag)
        if((imageView1.tag == 10 && imageView2.tag == 20 && imageView3.tag == 30) || (imageView2.tag == 20 && imageView3.tag == 30 && imageView4.tag == 40) || (imageView1.tag == 10 && imageView2.tag == 20 && imageView4.tag == 40)){
            
            
            
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Terminar") {
                
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            alertView.showSuccess("Correcto", subTitle: ":)")
            print("correcto")
            
           
            //navigationController?.popViewController(animated: true)
            
            
            
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
    
    func addObservers3() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.gameHasEnded3), name: Notification.Name("game3HasEndedNotification"), object: nil)
    }
    
    @objc func gameHasEnded3() {
        checkIfImagesInOrder3()
    }
}

