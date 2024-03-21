//
//  WalkThroughVC.swift
//  AirCloset
//
//  Created by cql105 on 28/03/23.
//

import UIKit
import AdvancedPageControl

class WalkThroughVC: UIViewController {
    
    // Mark :--> Outlets
    @IBOutlet weak var walkThroughColVw: UICollectionView!
    @IBOutlet weak var adPageControlVw: AdvancedPageControlView!
    @IBOutlet weak var btnNext: UIButton!
    
    //Mark :--> Variables
    var imgWalkThroughAry = ["walkThrough","walkThrough","walkThrough"]
    var walkData = [WalkData]()
    var visibleIndex = 0
    var currentlyShowingIndex = 0
    var selectIndex = 0
    
    //Mark :--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        walkThroughColVw.delegate = self
        walkThroughColVw.dataSource = self
        walkData.append(WalkData(title: "Browse local closets", des: "A safe platform for users to connect with locals and rent outfits."))
        walkData.append(WalkData(title: "List closet items", des: "Turn your closet into side hustle and start making money today."))
        walkData.append(WalkData(title: "Save time and money", des: "Connect with locals and book outfits in advance or last minute.."))
        adPageControlVw.drawer = ExtendedDotDrawer()
        adPageControlVw.drawer = ExtendedDotDrawer(numberOfPages: 3, height: 6, width: 16, space: 5, raduis: 10, currentItem: 0, indicatorColor: UIColor.white, dotsColor: UIColor.lightGray, isBordered: false, borderColor: UIColor.clear, borderWidth: 0, indicatorBorderColor: UIColor.clear, indicatorBorderWidth: 0)
    }
    
    //Mark:--> Actions
    @IBAction func tapNextBtn(_ sender: UIButton) {
        selectIndex += 1
        if selectIndex == 0 {
            btnNext.setTitle("Next", for: .normal)
            self.walkThroughColVw.isPagingEnabled = false
            self.walkThroughColVw.scrollToItem(at: IndexPath(row: selectIndex, section: 0), at: .centeredHorizontally, animated: true)
            self.walkThroughColVw.isPagingEnabled = true
            self.walkThroughColVw.reloadData()
        }
        else if selectIndex == 1 {
            btnNext.setTitle("Next", for: .normal)
            self.walkThroughColVw.isPagingEnabled = false
            self.walkThroughColVw.scrollToItem(at: IndexPath(row: selectIndex, section: 0), at: .centeredHorizontally, animated: true)
            self.walkThroughColVw.isPagingEnabled = true
            walkThroughColVw.isPagingEnabled = true
        }
        else if selectIndex == 2 {
            self.walkThroughColVw.isPagingEnabled = false
            self.walkThroughColVw.scrollToItem(at: IndexPath(row: selectIndex, section: 0), at: .centeredHorizontally, animated: true)
            self.walkThroughColVw.isPagingEnabled = true
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
            self.navigationController?.pushViewController(vc, animated: true)
            walkThroughColVw.isPagingEnabled = true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / width
        let roundedIndex = round( index )
        self.visibleIndex = Int(roundedIndex)
        self.selectIndex = Int(roundedIndex)
        adPageControlVw.setPage(Int(index))
    }
}

//MARK:-->  DelegateDataSources
extension WalkThroughVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgWalkThroughAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = walkThroughColVw.dequeueReusableCell(withReuseIdentifier: "WalkThroughCVCell", for: indexPath) as! WalkThroughCVCell
        cell.walkThroughImgVw.image = UIImage(named: imgWalkThroughAry[indexPath.row])
        cell.lblTitle.text = walkData[indexPath.row].title
        cell.lblDes.text = walkData[indexPath.row].des
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}


struct WalkData {
    var title: String
    var des: String
}
