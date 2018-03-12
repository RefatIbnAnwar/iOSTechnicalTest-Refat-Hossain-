//
//  GridViewController.swift
//  iOSTechnicalTest
//
//  Created by iMac on 12/3/18.
//  Copyright © 2018 mcc. All rights reserved.
//

import UIKit

class GridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var urlForData : String = "http://nationalappsbangladesh.com/mobsvc/ContentFile.php"
    var parameters : String = "AppID=9&MenuID=35"
    var imageArray = [String]()
    var titleArray = [String]()
    var itemURL : String = ""
    var imageTitle : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        layout.itemSize = CGSize(width: collectionView.bounds.size.width/4, height: collectionView.bounds.size.height/4)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout

        let apiCall = APICall()
        apiCall.getDataFromJson(url: urlForData, parameter: parameters) { (jsonData) in
            let arrayOfInformation = jsonData["contentfilelist"] as! [Any]
            for each in arrayOfInformation {
                let eachDict = each as! [String : Any]
                let imageUrl = eachDict["IMG"] as! String
                let titleName = eachDict["Title"] as! String
                if imageUrl != "" {
                    self.imageArray.append(eachDict["IMG"] as! String)
                    self.titleArray.append(titleName)
                }
                
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueID" {
            if let destinationVC = segue.destination as? ImageViewController {
                destinationVC.imageURL = self.itemURL
            }
        }
        
    }
 
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    
    // MARK: Datasource Methods for collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! GallaryCollectionViewCell
        cell.imageview.downloadedFrom(link: imageArray[indexPath.row], contentMode: .scaleAspectFill)
        cell.titleLabel.text = titleArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.itemURL = imageArray[indexPath.row]
        self.imageTitle = titleArray[indexPath.row]
        print(itemURL)
        performSegue(withIdentifier: "segueID", sender: nil)
    }
    
  

}
