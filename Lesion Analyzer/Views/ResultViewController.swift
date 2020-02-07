//
//  ResultViewController.swift
//  Lesion Analyzer
//
//  Created by Tran Quang Dat on 5/28/19.
//  Copyright © 2019 Tran Quang Dat. All rights reserved.
//

import UIKit
import CoreML
import Vision
import AudioToolbox.AudioServices

class ResultViewController: UIViewController {

    @IBOutlet weak var skinIv: UIImageView!
    @IBOutlet weak var resultLb: UILabel!
    @IBOutlet weak var riskLb: UILabel!
    @IBOutlet weak var askDoctorBtn: UIButton!
    
    var image: UIImage?
    
    let lesions = [
//        "0": "CNV",
//        "1": "DME",
//        "2": "DRUSEN",
//        "3": "NORMAL"
        "CNV": "CNV",
        "DME": "DME",
        "DRUSEN": "DRUSEN",
        "NORMAL": "NORMAL"
    ]
 
    
    lazy var classifierRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: xcode_train92().model)
            return VNCoreMLRequest(model: model, completionHandler: handleClassifier    )
        } catch {
            fatalError("Can't load CoreML model")
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.skinIv.image = self.image
        self.askDoctorBtn.layer.cornerRadius = 10
        self.askDoctorBtn.clipsToBounds = true
        
        do {
            let ciimage = CIImage(image: self.image!)!
            let handler = VNImageRequestHandler(ciImage: ciimage)
            try handler.perform([classifierRequest])
        } catch {
            print(error)
        }
    }
    
    func handleClassifier(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNClassificationObservation] else { fatalError("Unexpected result type") }
        print("===========")
        
        DispatchQueue.main.async {
            var result = [String]()
            var isRisk = false
            for i in 0...3 {
                let obs = observations[i]
                let confidence = String(format: "%.2f", obs.confidence*100)
                let lesion = self.lesions[obs.identifier]!
                result.append("\(lesion): \(confidence)%")
                
                if obs.identifier != "NORMAL" && obs.confidence > 0.7 {
                    isRisk = true
                }
            }
            
            let topConfident = observations[0].confidence
            if 0...0.3 ~= topConfident  {
                self.riskLb.text = "ĐỘ NGUY HIỂM CAO"
            } else if 0.3...0.6 ~= topConfident {
                self.riskLb.text = "ĐỘ NGUY HIỂM VỪA"
            } else {
                self.riskLb.text = "ĐỘ NGUY HIỂM THẤP"
            }
            
//            for obs in observations {
//                let confidence = String(format: "%.2f", obs.confidence*100)
//                let lesion = self.lesions[obs.identifier]!
//                print("\(lesion): \(confidence)")
//            }
//            print(result)
            self.resultLb.text = result.joined(separator: "\n")
            
            if isRisk {
                self.riskLb.text = "You have eye problems!"
                self.riskLb.isHidden = false
                
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
        }
    }
    
    @IBAction func done(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func askDoctor(_ sender: Any) {
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let destinationController = segue.destination as? DoctorListViewController {
            destinationController.octImage = image
        }
    }

}
