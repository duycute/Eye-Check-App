//
//  ViewController.swift
//  Lesion Analyzer
//
//  Created by Tran Quang Dat on 4/19/19.
//  Copyright © 2019 Tran Quang Dat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var UVIv: UIImageView!
    @IBOutlet weak var UVLb: UILabel!
    @IBOutlet weak var skinLb: UILabel!
    @IBOutlet weak var historyTv: UITableView!
    
    let skins: [UIImage] = [
        UIImage(named: "skin_high")!,
        UIImage(named: "skin_medium")!
    ]
    let risks: [String] = [
        "Choroidal neovascularization (CNV)",
        "Diabetic Macular Edema (DME)",
        "DRUSEN",
        "NORMAL"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Eye Check"
//        self.skinLb.text = "👨‍🦰\n Châu Á\n"
        self.historyTv.delegate = self
        self.historyTv.dataSource = self
        self.historyTv.estimatedRowHeight = 112
        self.historyTv.rowHeight = UITableView.automaticDimension
//        self.historyTv.setNeedsLayout()
//        self.historyTv.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func pickImage(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Choose photo", style: .default, handler: { _ in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.dismiss(animated: true)
        }))
        present(alertController, animated: true)
    }
}

extension MainViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Không thể lấy ảnh từ Bộ sưu tập")
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        vc.image = image
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UINavigationControllerDelegate {
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.risks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
//        cell.skinIv.image = skins[indexPath.row]
        cell.riskLabel.text = risks[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            present(url: URL(string: "https://en.wikipedia.org/wiki/Choroidal_neovascularization")!)
        } else if indexPath.row == 1 {
            present(url: URL(string: "https://en.wikipedia.org/wiki/Macular_edema")!)
        } else if indexPath.row == 2 {
            present(url: URL(string: "https://en.wikipedia.org/wiki/Drusen")!)
        } else if indexPath.row == 3 {
        }
    }
}

