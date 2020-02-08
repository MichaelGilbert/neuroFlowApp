//
//  FirstViewController.swift
//  NeuroFlowProject
//
//  Created by Michael Gilbert on 2/6/20.
//  Copyright © 2020 Michael Gilbert. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    let dataCount = 6
    let colors: [UIColor] = [.black, .blue, .brown, .cyan, .red, .green]

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCell
        
        cell.colorView.backgroundColor = self.colors[indexPath.row]
        return cell
    }
}

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 5;
        let collectionViewHeight = collectionView.bounds.height
        let numberOfRows:CGFloat = 4.0
        var size:CGSize
        
        switch(indexPath.row) {
        case 0, 5:
            size = CGSize(width: collectionViewWidth, height: collectionViewHeight/numberOfRows)
            
        case 1...4:
            size = CGSize(width: collectionViewWidth/2, height: collectionViewHeight/numberOfRows)
        
        default:
        size = CGSize(width: collectionViewWidth, height: collectionViewHeight/numberOfRows)
        }
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

