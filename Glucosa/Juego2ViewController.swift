//
//  Juego2ViewController.swift
//  Glucosa
//
//  Created by Ricardo on 4/16/17.
//  Copyright © 2017 Ricardo. All rights reserved.
//

import UIKit
import DIOCollectionView
import SCLAlertView

class Juego2ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var collectionView2: DIOCollectionView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    var items1 = [(10, "Glucosa"),
                  (20, "Celulosa"),
                  (30, "Celobiosa")]
    
    var itemsAux = [(Int, String)]()
    
    func itemsForCollectionView(collectionView: UICollectionView) -> [(Int, String)] {
        if(collectionView == collectionView2) {
            //items1 = itemsAux
            return items1
        }
        return []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers2()
        imageView1.image = UIImage(named: "glucosa")
        imageView3.image = UIImage(named: "celulosa")
        imageView2.image = UIImage(named: "celobiosa")
        // Do any additional setup after loading the view.
        collectionView2.delegate = self
        collectionView2.dataSource = self
        collectionView2.dioDataSource = self
        collectionView2.dioDelegate = self
        itemsAux = items1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func reload(){
        label1.text = ""
        label2.text = ""
        label3.text = ""
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Juego2ViewController: DIOCollectionViewDelegate {
    func dioCollectionView(_ dioCollectionView: DIOCollectionView,
                           draggedItemAtIndexPath indexPath: IndexPath,
                           withDragState dragState: DIODragState) {
        switch(dragState) {
            
            // case .began:
            //self.items1.remove(at: indexPath.row)
            //self.collectionView1.deleteItems(at: [indexPath])
            
        case .ended:
            items1.remove(at: indexPath.row)
            collectionView2.deleteItems(at: [indexPath])
            
        default:
            break
        }
    }
}

extension Juego2ViewController: DIOCollectionViewDataSource {
    func dioCollectionView(_ dioCollectionView: DIOCollectionView,
                           userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        let cellData = itemsForCollectionView(collectionView: dioCollectionView)[indexPath.row]
        return cellData
    }
}

extension Juego2ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
        
        let label  = cell.subviews[0].subviews[0] as! UILabel
      
        
        let item = itemsForCollectionView(collectionView: collectionView)[indexPath.row]
        print(item)
        
        
        //label.text = "\(item.0)"
        label.text = item.1
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsForCollectionView(collectionView: collectionView).count
        
    }
}

extension Juego2ViewController: UICollectionViewDelegate {}

private extension Juego2ViewController {
    func checkIfImagesInOrder2() {
        print(label1.tag)
        print(label2.tag)
        print(label3.tag)
        if(label1.tag == 10 && label2.tag == 20 || label2.tag == 20 && label3.tag == 30 || label1.tag == 10 && label3.tag == 30){
            SCLAlertView().showSuccess("Correcto", subTitle: ":)")
            print("correcto")
            
            //Instantiate next VC
            
        } else {
            SCLAlertView().showError("Incorrecto", subTitle: ":(")
            print("incorrecto")
            reload()
            print(items1)
            items1 = itemsAux
            print(itemsAux)
            self.collectionView2.reloadData()
            
        }
    }
    
    func addObservers2() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.gameHasEnded), name: Notification.Name("gameHasEndedNotification2"), object: nil)
    }
    
    @objc func gameHasEnded() {
        checkIfImagesInOrder2()
    }
}

