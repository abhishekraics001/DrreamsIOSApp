//
//  BooksViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/9/21.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var subView:UIView!
    @IBOutlet weak var subjectTable:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.mainShadow()
        subView.innerShadow()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
               //return 2
           return 1
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subjectTable.dequeueReusableCell(withIdentifier: "SubjectCell", for:indexPath) as! SubjectCell
        return cell
    }
    @IBAction func backAction (_: UIButton){
          
          // self.present(viewCtrl, animated: true, completion: nil)
          self.navigationController?.popViewController(animated: true)
      }
}
