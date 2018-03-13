//
//  ImageListViewController.swift
//  ImageReader
//
//  Created by lionking on 2018/3/13.
//  Copyright © 2018年 lionKing. All rights reserved.
//

import UIKit

class ImageListViewController: UITableViewController {
    
    var dataArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _readData()
    }
    
    func _readData()
    {
        let arr = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let path = arr[0]
        let fileManager = FileManager.init()
        let fileEnumerator = fileManager.enumerator(atPath: path)
        let fileArr = fileEnumerator!.allObjects
        if fileArr.count > 0
        {
            dataArray = fileArr as! [String]
        }
        dataArray.sort()
    }
    @IBAction func reloadImageList(_ sender: Any) {
        _readData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "ImageListCellId", for: indexPath)) as UITableViewCell
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = dataArray[indexPath.row]
        self.performSegue(withIdentifier: "ShowImageSegue", sender: title)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController
        {
            vc.clickText = sender as? String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
