//
//  JuegoViewController.swift
//  Glucosa
//
//  Created by Ricardo on 4/16/17.
//  Copyright © 2017 Ricardo. All rights reserved.
//

import UIKit
import DIOCollectionView


class JuegoViewController: UIViewController, UICollectionViewDelegate, DIOCollectionViewDelegate, UICollectionViewDataSource, DIOCollectionViewDataSource {
    
    @IBOutlet weak var collectionView1: DIOCollectionView!
    
    var items1 = [("Celulosa", UIImage(named:"celulosa")!), ("Celobiosa", UIImage(named:"celobiosa")!), ("Glucosa", UIImage(named:"glucosa")!)]

    
    func itemsForCollectionView(collectionView: UICollectionView) -> [(String, UIImage)] {
        print("itemsForCollectionView")
        if(collectionView == collectionView1) {
            return items1
        }
       
        
        return []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.dioDataSource = self
        collectionView1.dioDelegate = self
        
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("ViewDidAppear")
        navigationController?.navigationBar.isHidden = false
    }
    
    
    //DIOCollectionView Data Source
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        print("userDataForItemAtIndexPath")

        let cellData = itemsForCollectionView(collectionView: dioCollectionView)[indexPath.row]
        
        print(cellData)
        
        return cellData
    }
    
    //DIOCollectionView Data Delegate
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, draggedItemAtIndexPath indexPath: IndexPath, withDragState dragState: DIODragState) {
        print("draggedForItem")

        switch(dragState) {
            
//        case .began:
//            self.items1.remove(at: indexPath.row)
//            self.collectionView1.deleteItems(at: [indexPath])
            
        case .ended:
            self.items1.remove(at: indexPath.row)
            self.collectionView1.deleteItems(at: [indexPath])
            //Checar si los 3 están correctos
            
        default:
            break
        }
    }
    
    
    //CollectionView Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("numberOfSections")

        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItem")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        let imageView  = cell.subviews[0].subviews[0] as! UIImageView
        let label = cell.subviews[0].subviews[1] as! UILabel
        
        let item = itemsForCollectionView(collectionView: collectionView)[indexPath.row]
        print(item)
        //let label as UILabel()!
        
        
        label.text = "\(item.0)"
        imageView.image = item.1
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsForCollectionView(collectionView: collectionView).count

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
