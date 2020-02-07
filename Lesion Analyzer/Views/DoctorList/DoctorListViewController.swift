//
//  DoctorListViewController.swift
//  Lesion Analyzer
//
//  Created by SM on 28/11/2019.
//  Copyright © 2019 Tran Quang Dat. All rights reserved.
//

import UIKit
import MessageUI

class DoctorListViewController: UIViewController {
    @IBOutlet weak var doctorTableView: UITableView!
    var octImage: UIImage?
    
    let dataSource: [(name: String, title: String, email: String)] = [(" Anupam kr. Singh", title: "Doctor at Rotary Eye Care Centre", "duytruong252@gmail.com"),
    ("Ngô Thanh Hoàn", title: "Lecturer at International Uni. - Vietnam", "nthoan@hcmiu.edu.vn"),
    ("Võ Thị Hoàng Lan", title: "Doctor at University Medical Center HCMC", "thuydieu1219@gmail.com"),
    ("Ngô Thanh Tùng", title: "HCM Eye Hospital", "duytruong352@gmail.com")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func sendMail(email: String) {
      if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self;
        mail.setToRecipients([email])
        mail.setSubject("Helping to detective_OCT image")
        mail.setMessageBody("", isHTML: false)
        if let image = octImage, let imageData = image.pngData() {
            mail.addAttachmentData(imageData, mimeType: "image/png", fileName: "imageName.png")
            self.present(mail, animated: true, completion: nil)
        }
      }
    }

}

extension DoctorListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell") as? DoctorCell {
            cell.nameLabel.text = data.name
            cell.titleLabel.text = data.title
            
            if (indexPath.row == 1) {
                cell.avatarImageView.image = UIImage(named: "teacher")
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataSource[indexPath.row]
        
        sendMail(email: data.email)
    }
}

extension DoctorListViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

