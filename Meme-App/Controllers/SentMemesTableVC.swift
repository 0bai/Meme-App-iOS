//
//  SentMemesTableVC.swift
//  Meme-App
//
//  Created by Obai Alnajjar on 4/24/19.
//  Copyright © 2019 Obai Alnajjar. All rights reserved.
//

import UIKit

class SentMemesTableVC: UIViewController{
    
    @IBOutlet weak var memesTable: UITableView!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memesTable.reloadData()
    }
    
}


extension SentMemesTableVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TMemeCell", for: indexPath) as! MemeTableCell
        
        cell.meme = memes[indexPath.row]
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "TableToPreview", sender: tableView.cellForRow(at: indexPath))
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableToPreview"{
        let previewVC = segue.destination as! MemePreviewVC
            let cell = sender as! MemeTableCell
            previewVC.meme = memes[cell.tag]
        }
        
    }

}
