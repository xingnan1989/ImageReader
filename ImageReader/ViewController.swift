//
//  ViewController.swift
//  ImageReader
//
//  Created by lionking on 2018/3/13.
//  Copyright © 2018年 lionKing. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var clickText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = clickText
        scrollView.delegate = self
        
        let arr = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let path = arr[0]
        if let imageName = clickText {
            let path = String.init(format: "%@/%@",path,imageName)
            let image = UIImage.init(contentsOfFile: path)
            let imageWidth = self.view.frame.size.width
            let imageHeight = imageWidth * (image?.size.height)! / (image?.size.width)!
            let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: imageWidth, height: imageHeight))
            imageView.image = image
            imageView.isUserInteractionEnabled = false
            scrollView.addSubview(imageView)
            
            scrollView.contentSize = CGSize.init(width: imageWidth, height: imageHeight)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -5 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else if velocity > 5 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

